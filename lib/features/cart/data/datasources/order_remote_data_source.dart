import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:street_bite/core/errors/error_handler.dart';
import 'package:street_bite/core/errors/failures.dart';
import 'package:street_bite/features/cart/domain/entities/cart_item.dart';
import 'package:street_bite/features/cart/domain/entities/payment_result.dart';

class OrderRemoteDataSource {
  const OrderRemoteDataSource(this._firestore, this._firebaseAuth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  Future<Either<Failure, String>> placeOrder({
    required List<CartItem> items,
    required double total,
    required PaymentResult payment,
  }) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      return const Left(UnauthorizedFailure());
    }
    if (items.isEmpty || total <= 0) {
      return const Left(UnexpectedFailure());
    }

    try {
      final order = await _ordersCollection(userId).add({
        'items': items
            .map(
              (item) => {
                'mealId': item.meal.id,
                'name': item.meal.name,
                'thumbnail': item.meal.thumbnail,
                'unitPrice': item.unitPrice,
                'quantity': item.quantity,
                'total': item.total,
              },
            )
            .toList(),
        'total': total,
        'currency': 'EGP',
        'payment': payment.toJson(),
        'status': 'placed',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return Right(order.id);
    } catch (error, stackTrace) {
      return Left(handleError(error, stackTrace));
    }
  }

  CollectionReference<Map<String, dynamic>> _ordersCollection(String userId) =>
      _firestore.collection('users').doc(userId).collection('orders');
}
