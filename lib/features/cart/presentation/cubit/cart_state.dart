import 'package:equatable/equatable.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/cart/domain/entities/cart_item.dart';

enum CartStatus { idle, placingOrder, placed, failure }

class CartState extends Equatable {
  const CartState({
    this.items = const [],
    this.status = CartStatus.idle,
    this.failure,
    this.orderId,
  });

  final List<CartItem> items;
  final CartStatus status;
  final Failure? failure;
  final String? orderId;

  double get total => items.fold(0, (sum, item) => sum + item.total);

  CartState copyWith({
    List<CartItem>? items,
    CartStatus? status,
    Failure? failure,
    String? orderId,
    bool clearFailure = false,
    bool clearOrderId = false,
  }) => CartState(
    items: List.unmodifiable(items ?? this.items),
    status: status ?? this.status,
    failure: clearFailure ? null : failure ?? this.failure,
    orderId: clearOrderId ? null : orderId ?? this.orderId,
  );

  @override
  List<Object?> get props => [items, status, failure, orderId];
}
