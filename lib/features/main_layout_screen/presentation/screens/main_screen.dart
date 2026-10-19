import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:street_bite/core/routing/app_routes.dart';
import 'package:street_bite/core/services/biometric_service.dart';
import 'package:street_bite/features/cart/presentation/screens/cart_screen.dart';
import 'package:street_bite/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:street_bite/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:street_bite/features/home/presentation/screens/home_screen.dart';
import 'package:street_bite/features/profile/domain/repositories/profile_repository.dart';
import 'package:street_bite/features/profile/presentation/screens/profile_screen.dart';
import 'package:street_bite/injection.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _authenticatingForProfile = false;
  bool _profileAuthorized = false;
  UserEntity? _profileUser;

  Future<void> _onDestinationSelected(int index) async {
    if (index == 3) {
      if (_authenticatingForProfile) return;
      _authenticatingForProfile = true;

      try {
        final authenticated = await sl<BiometricService>().authenticate(
          localizedReason: 'profile.biometric_reason'.tr(),
        );
        if (!mounted) return;
        if (!authenticated) {
          _showMessage('profile.biometric_cancelled'.tr());
          return;
        }
        _profileAuthorized = true;
      } on LocalAuthException catch (error) {
        if (!mounted) return;
        _showMessage(
          'profile.biometric_error'.tr(namedArgs: {'error': error.code.name}),
        );
        return;
      } on StateError {
        if (!mounted) return;
        _showMessage('profile.biometric_unavailable'.tr());
        return;
      } on MissingPluginException {
        if (!mounted) return;
        _showMessage('profile.biometric_unavailable'.tr());
        return;
      } finally {
        _authenticatingForProfile = false;
      }
    }

    if (!mounted) return;
    setState(() => _currentIndex = index);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _profileScreen() => BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      if (state is AuthAuthenticated) _profileUser = state.user;
      final user = state is AuthAuthenticated ? state.user : _profileUser;
      if (user != null && state is! AuthUnauthenticated) {
        return ProfileScreen(user: user, repository: sl<ProfileRepository>());
      }
      if (state is AuthLoading || state is AuthInitial) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: AppBar(title: Text('profile.title'.tr())),
        body: Center(child: Text('profile.sign_in_required'.tr())),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomeScreen(),
      const FavoriteScreen(),
      const CartScreen(),
      _profileAuthorized ? _profileScreen() : const SizedBox.shrink(),
    ];
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.goNamed(AppRoutes.loginScreen);
        }
      },
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: screens),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onDestinationSelected,
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex != 0
                  ? Icon(Icons.home_outlined)
                  : Icon(Icons.home),
              label: 'navigation.home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex != 1
                  ? Icon(Icons.favorite_border)
                  : Icon(Icons.favorite),
              label: 'navigation.favourites'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex != 2
                  ? Icon(Icons.shopping_cart_outlined)
                  : Icon(Icons.shopping_cart),
              label: 'navigation.cart'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex != 3
                  ? Icon(Icons.person_outline)
                  : Icon(Icons.person),
              label: 'navigation.profile'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
