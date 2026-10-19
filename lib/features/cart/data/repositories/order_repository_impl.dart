import 'package:dartz/dartz.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/cart/data/datasources/order_remote_data_source.dart';
import 'package:street_bite/features/cart/domain/entities/cart_item.dart';
import 'package:street_bite/features/cart/domain/entities/payment_result.dart';
import 'package:street_bite/features/cart/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl(this._remoteDataSource);

  final OrderRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, String>> placeOrder({
    required List<CartItem> items,
    required double total,
    required PaymentResult payment,
  }) => _remoteDataSource.placeOrder(
    items: items,
    total: total,
    payment: payment,
  );
}
