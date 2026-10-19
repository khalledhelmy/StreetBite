import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:street_bite/core/services/firestore_service.dart';
import 'package:street_bite/features/home/data/models/meal_model.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/profile/domain/entities/profile_order.dart';
import 'package:street_bite/features/profile/domain/entities/profile_order_item.dart';

class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this._firestoreService);

  final FirestoreService _firestoreService;

  Stream<List<MealEntity>> watchFavorites(String userId) => _firestoreService
      .userCollection(userId, 'favorites')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((document) {
          final data = document.data();
          data['idMeal'] ??= document.id;
          return MealModel.fromJson(data);
        }).toList(),
      );

  Stream<List<ProfileOrder>> watchOrders(String userId) => _firestoreService
      .userCollection(userId, 'orders')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((document) => _orderFromDocument(document))
            .toList(),
      );

  ProfileOrder _orderFromDocument(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    final payment = data['payment'] as Map<String, dynamic>;
    final createdAt = data['createdAt'];
    final items = data['items'] as List<dynamic>;

    return ProfileOrder(
      id: document.id,
      total: (data['total'] as num).toDouble(),
      currency: data['currency'] as String,
      status: data['status'] as String,
      paymentMethod: payment['method'] as String,
      createdAt: createdAt is Timestamp ? createdAt.toDate() : null,
      items: items.map((value) {
        final item = value as Map<String, dynamic>;
        return ProfileOrderItem(
          name: item['name'] as String,
          quantity: item['quantity'] as int,
          total: (item['total'] as num).toDouble(),
          thumbnail: item['thumbnail'] as String,
        );
      }).toList(),
    );
  }
}
