import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/cart/domain/entities/cart_item.dart';
import 'package:street_bite/features/cart/domain/entities/payment_result.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, String>> placeOrder({
    required List<CartItem> items,
    required double total,
    required PaymentResult payment,
  });
}
