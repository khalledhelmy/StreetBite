import 'package:street_bite/features/home/domain/entities/meal_entity.dart';
import 'package:street_bite/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:street_bite/features/profile/domain/entities/profile_order.dart';
import 'package:street_bite/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Stream<List<MealEntity>> watchFavorites(String userId) =>
      _remoteDataSource.watchFavorites(userId);

  @override
  Stream<List<ProfileOrder>> watchOrders(String userId) =>
      _remoteDataSource.watchOrders(userId);
}
