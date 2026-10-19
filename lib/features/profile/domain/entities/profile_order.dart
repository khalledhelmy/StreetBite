import 'package:equatable/equatable.dart';
import 'package:street_bite/features/profile/domain/entities/profile_order_item.dart';

class ProfileOrder extends Equatable {
  const ProfileOrder({
    required this.id,
    required this.total,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    required this.items,
  });

  final String id;
  final double total;
  final String currency;
  final String status;
  final String paymentMethod;
  final DateTime? createdAt;
  final List<ProfileOrderItem> items;

  @override
  List<Object?> get props => [
    id,
    total,
    currency,
    status,
    paymentMethod,
    createdAt,
    items,
  ];
}
