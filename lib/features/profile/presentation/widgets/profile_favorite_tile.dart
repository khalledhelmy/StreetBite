import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class ProfileFavoriteTile extends StatelessWidget {
  const ProfileFavoriteTile({super.key, required this.meal});

  final MealEntity meal;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: meal.thumbnail.isEmpty
            ? null
            : CachedNetworkImageProvider(meal.thumbnail),
        child: meal.thumbnail.isEmpty ? const Icon(Icons.restaurant) : null,
      ),
      title: Text(meal.name),
      subtitle: Text(meal.category),
    ),
  );
}
