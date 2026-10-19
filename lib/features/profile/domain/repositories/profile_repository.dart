import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/profile/domain/entities/profile_order.dart';

abstract interface class ProfileRepository {
  Stream<List<MealEntity>> watchFavorites(String userId);
  Stream<List<ProfileOrder>> watchOrders(String userId);
}
