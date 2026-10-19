import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:street_bite/core/routing/app_routes.dart';
import 'package:street_bite/core/widgets/change_theme_widget.dart';
import 'package:street_bite/core/widgets/language_switcher.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:street_bite/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/profile/domain/entities/profile_order.dart';
import 'package:street_bite/features/profile/domain/repositories/profile_repository.dart';
import 'package:street_bite/features/profile/presentation/widgets/profile_empty_section.dart';
import 'package:street_bite/features/profile/presentation/widgets/profile_favorite_tile.dart';
import 'package:street_bite/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:street_bite/features/profile/presentation/widgets/profile_order_card.dart';
import 'package:street_bite/features/profile/presentation/widgets/profile_section_header.dart';
import 'package:street_bite/features/profile/presentation/widgets/profile_stream_error.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.user,
    required this.repository,
  });

  final UserEntity user;
  final ProfileRepository repository;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? _localPhoto;
  late Stream<List<MealEntity>> _favoritesStream;
  late Stream<List<ProfileOrder>> _ordersStream;
  bool _loggingOut = false;

  @override
  void initState() {
    super.initState();
    _listenToProfileData();
  }

  void _listenToProfileData() {
    _favoritesStream = widget.repository.watchFavorites(widget.user.id);
    _ordersStream = widget.repository.watchOrders(widget.user.id);
  }

  Future<void> _choosePhoto() async {
    try {
      final photo = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (photo == null) return;
      final imageBytes = await photo.readAsBytes();
      if (!mounted) return;
      setState(() => _localPhoto = imageBytes);
    } on PlatformException {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('profile.photo_error'.tr())));
    }
  }

  void _retryStreams() {
    setState(_listenToProfileData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile.title'.tr()),
        leading: const ChangeThemeWidget(),

        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 16.w),
            child: const LanguageSwitcher(),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        children: [
          ProfileHeaderCard(
            name: widget.user.name,
            email: widget.user.email,
            imageProvider: _profileImageProvider(),
            onChoosePhoto: _choosePhoto,
          ),
          HeightSpace(20),
          ProfileSectionHeader(title: 'profile.order_history'.tr()),
          HeightSpace(8),
          StreamBuilder<List<ProfileOrder>>(
            stream: _ordersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ProfileStreamError(onRetry: _retryStreams);
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final orders = snapshot.data!;
              if (orders.isEmpty) {
                return ProfileEmptySection(message: 'profile.no_orders'.tr());
              }
              return Column(
                children: orders
                    .map((order) => ProfileOrderCard(order: order))
                    .toList(),
              );
            },
          ),
          HeightSpace(20),
          ProfileSectionHeader(title: 'profile.favorites'.tr()),
          HeightSpace(8),
          StreamBuilder<List<MealEntity>>(
            stream: _favoritesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ProfileStreamError(onRetry: _retryStreams);
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final favorites = snapshot.data!;
              if (favorites.isEmpty) {
                return ProfileEmptySection(
                  message: 'profile.no_favorites'.tr(),
                );
              }
              return Column(
                children: favorites
                    .map((meal) => ProfileFavoriteTile(meal: meal))
                    .toList(),
              );
            },
          ),
          HeightSpace(24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _loggingOut ? null : _confirmLogout,
              icon: _loggingOut
                  ? SizedBox.square(
                      dimension: 18.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.logout),
              label: Text('profile.logout'.tr()),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('profile.logout'.tr()),
        content: Text('profile.logout_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('profile.cancel'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('profile.logout'.tr()),
          ),
        ],
      ),
    );
    if (shouldLogout != true || !mounted) return;

    setState(() => _loggingOut = true);
    final authCubit = context.read<AuthCubit>();
    await authCubit.logout();
    if (!mounted) return;

    final state = authCubit.state;
    if (state is AuthUnauthenticated) {
      context.goNamed(AppRoutes.loginScreen);
    } else if (state is AuthError) {
      setState(() => _loggingOut = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(state.failure.message)));
    }
  }

  ImageProvider? _profileImageProvider() {
    if (_localPhoto != null) return MemoryImage(_localPhoto!);
    final photoUrl = widget.user.photoUrl;
    if (photoUrl == null || photoUrl.isEmpty) return null;
    return CachedNetworkImageProvider(photoUrl);
  }
}
