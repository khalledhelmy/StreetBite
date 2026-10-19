import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/cart/domain/entities/cart_item.dart';
import 'package:street_bite/features/cart/domain/entities/payment_result.dart';
import 'package:street_bite/features/cart/domain/repositories/order_repository.dart';

class PlaceOrder {
  const PlaceOrder(this._repository);

  final OrderRepository _repository;

  Future<Either<Failure, String>> call({
    required List<CartItem> items,
    required double total,
    required PaymentResult payment,
  }) => _repository.placeOrder(items: items, total: total, payment: payment);
}
