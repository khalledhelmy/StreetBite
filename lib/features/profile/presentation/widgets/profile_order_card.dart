import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/profile/domain/entities/profile_order.dart';

class ProfileOrderCard extends StatelessWidget {
  const ProfileOrderCard({super.key, required this.order});

  final ProfileOrder order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = order.createdAt == null
        ? null
        : MaterialLocalizations.of(context).formatMediumDate(order.createdAt!);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'profile.order_number'.tr(namedArgs: {'id': order.id}),
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Text(
                  '${order.total.toStringAsFixed(2)} ${order.currency}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            if (date != null) ...[
              HeightSpace(4),
              Text(date, style: theme.textTheme.bodySmall),
            ],
            HeightSpace(4),
            Text(
              '${'profile.order_status'.tr()}: ${'profile.order_status_${order.status}'.tr()}',
              style: theme.textTheme.bodySmall,
            ),
            HeightSpace(4),
            Text(
              '${'profile.payment_method'.tr()}: ${'profile.payment_${order.paymentMethod}'.tr()}',
              style: theme.textTheme.bodySmall,
            ),
            HeightSpace(8),
            ...order.items.map(
              (item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Row(
                  children: [
                    Expanded(child: Text('${item.name} × ${item.quantity}')),
                    Text('${item.total.toStringAsFixed(2)} ${order.currency}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
