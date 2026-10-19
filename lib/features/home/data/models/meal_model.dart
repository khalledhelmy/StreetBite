import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class MealModel extends MealEntity {
  MealModel({
    required super.id,
    required super.name,
    required super.thumbnail,
    required super.category,
    required super.area,
    required super.instructions,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
    id: json['idMeal']?.toString() ?? '',
    name: json['strMeal']?.toString() ?? '',
    thumbnail: json['strMealThumb']?.toString() ?? '',
    category: json['strCategory']?.toString() ?? '',
    area: json['strArea']?.toString() ?? '',
    instructions: json['strInstructions']?.toString() ?? '',
  );

  factory MealModel.fromEntity(MealEntity meal) => MealModel(
    id: meal.id,
    name: meal.name,
    thumbnail: meal.thumbnail,
    category: meal.category,
    area: meal.area,
    instructions: meal.instructions,
  );

  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal': name,
    'strMealThumb': thumbnail,
    'strCategory': category,
    'strArea': area,
    'strInstructions': instructions,
  };
}
