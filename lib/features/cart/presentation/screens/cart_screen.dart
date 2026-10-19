import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/cart/domain/payment/card_payment.dart';
import 'package:street_bite/features/cart/domain/payment/cash_payment.dart';
import 'package:street_bite/features/cart/domain/payment/payment_method.dart';
import 'package:street_bite/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:street_bite/features/cart/presentation/cubit/cart_state.dart';
import 'package:street_bite/features/cart/presentation/widgets/cart_item_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PaymentMethod _paymentMethod = const CashPayment();
  final List<PaymentMethod> _paymentMethods = const [
    CashPayment(),
    CardPayment(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String formatPrice(double amount) =>
        '${amount.toStringAsFixed(2)} ${'cart.currency'.tr()}';

    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) =>
          (previous.items.isNotEmpty && current.items.isEmpty) ||
          (previous.status != CartStatus.failure &&
              current.status == CartStatus.failure),
      listener: (context, state) {
        if (state.status == CartStatus.failure && state.failure != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.failure!.message)));
        }
        if (state.items.isEmpty && state.status != CartStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.status == CartStatus.placed
                      ? 'cart.order_placed'.tr()
                      : 'cart.empty'.tr(),
                ),
              ),
            );
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('cart.title'.tr())),
            body: state.items.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 56.sp,
                            color: theme.colorScheme.primary,
                          ),
                          HeightSpace(16),
                          Text(
                            'cart.empty'.tr(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.items.length,
                    separatorBuilder: (context, index) => HeightSpace(12),
                    itemBuilder: (context, index) => CartItemTile(
                      item: state.items[index],
                      enabled: state.status != CartStatus.placingOrder,
                    ),
                  ),
            bottomNavigationBar: state.items.isEmpty
                ? null
                : SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'cart.payment_method'.tr(),
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          ..._paymentMethods.map(
                            (method) => RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              value: method.id,
                              groupValue: _paymentMethod.id,
                              title: Text(method.labelKey.tr()),
                              onChanged: state.status == CartStatus.placingOrder
                                  ? null
                                  : (value) {
                                      if (value == null) return;
                                      setState(() {
                                        _paymentMethod = _paymentMethods
                                            .firstWhere(
                                              (item) => item.id == value,
                                            );
                                      });
                                    },
                            ),
                          ),
                          if (_paymentMethod is CardPayment)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  'cart.simulated_payment_note'.tr(),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'cart.total'.tr(),
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                formatPrice(state.total),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          HeightSpace(12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state.status == CartStatus.placingOrder
                                  ? null
                                  : () => context.read<CartCubit>().placeOrder(
                                      _paymentMethod,
                                    ),
                              child: state.status == CartStatus.placingOrder
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text('cart.place_order'.tr()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
