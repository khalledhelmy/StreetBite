import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/cart/domain/entities/cart_item.dart';
import 'package:street_bite/features/cart/presentation/cubit/cart_cubit.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.item, required this.enabled});

  final CartItem item;
  final bool enabled;

  String _formatPrice(double amount) =>
      '${amount.toStringAsFixed(2)} ${'cart.currency'.tr()}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<CartCubit>();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: item.meal.thumbnail.trim().isEmpty
                  ? Container(
                      width: 76.w,
                      height: 76.w,
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.restaurant),
                    )
                  : CachedNetworkImage(
                      imageUrl: item.meal.thumbnail,
                      width: 76.w,
                      height: 76.w,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        width: 76.w,
                        height: 76.w,
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.restaurant),
                      ),
                    ),
            ),
            WidthSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.meal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall,
                  ),
                  HeightSpace(4),
                  Text(
                    _formatPrice(item.unitPrice),
                    style: theme.textTheme.bodySmall,
                  ),
                  HeightSpace(4),
                  Text(
                    '${'cart.line_total'.tr()}: ${_formatPrice(item.total)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  tooltip: 'cart.remove'.tr(),
                  visualDensity: VisualDensity.compact,
                  onPressed: enabled
                      ? () => cubit.removeMeal(item.meal.id)
                      : null,
                  icon: const Icon(Icons.delete_outline),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'cart.decrease_quantity'.tr(),
                      visualDensity: VisualDensity.compact,
                      onPressed: enabled
                          ? () => cubit.decreaseQuantity(item.meal.id)
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      tooltip: 'cart.increase_quantity'.tr(),
                      visualDensity: VisualDensity.compact,
                      onPressed: enabled
                          ? () => cubit.increaseQuantity(item.meal.id)
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
