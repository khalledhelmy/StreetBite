import 'package:equatable/equatable.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.meal,
    required this.unitPrice,
    this.quantity = 1,
  });

  final MealEntity meal;
  final double unitPrice;
  final int quantity;

  double get total => unitPrice * quantity;

  CartItem copyWith({int? quantity}) => CartItem(
    meal: meal,
    unitPrice: unitPrice,
    quantity: quantity ?? this.quantity,
  );

  @override
  List<Object?> get props => [
    meal.id,
    meal.name,
    meal.thumbnail,
    unitPrice,
    quantity,
  ];
}
