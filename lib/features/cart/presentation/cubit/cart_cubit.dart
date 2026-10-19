import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/features/cart/domain/entities/cart_item.dart';
import 'package:street_bite/features/cart/domain/payment/payment_method.dart';
import 'package:street_bite/features/cart/domain/usecases/place_order.dart';
import 'package:street_bite/features/cart/presentation/cubit/cart_state.dart';
import 'package:street_bite/features/home/domain/entities/meal_entity.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required PlaceOrder placeOrder, Random? random})
    : _placeOrder = placeOrder,
      _random = random ?? Random(),
      super(const CartState());

  static const int minMealPrice = 50;
  static const int maxMealPrice = 1000;

  final PlaceOrder _placeOrder;
  final Random _random;

  void addMeal(MealEntity meal) {
    if (state.status == CartStatus.placingOrder) return;

    final items = List<CartItem>.of(state.items);
    final index = items.indexWhere((item) => item.meal.id == meal.id);
    if (index == -1) {
      final price =
          minMealPrice + _random.nextInt(maxMealPrice - minMealPrice + 1);
      items.add(CartItem(meal: meal, unitPrice: price.toDouble()));
    } else {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + 1,
      );
    }
    emit(
      state.copyWith(
        items: items,
        status: CartStatus.idle,
        clearFailure: true,
        clearOrderId: true,
      ),
    );
  }

  void removeMeal(String mealId) {
    if (state.status == CartStatus.placingOrder) return;
    emit(
      state.copyWith(
        items: state.items.where((item) => item.meal.id != mealId).toList(),
        status: CartStatus.idle,
        clearFailure: true,
        clearOrderId: true,
      ),
    );
  }

  void decreaseQuantity(String mealId) {
    if (state.status == CartStatus.placingOrder) return;
    final items = List<CartItem>.of(state.items);
    final index = items.indexWhere((item) => item.meal.id == mealId);
    if (index == -1) return;

    if (items[index].quantity == 1) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity - 1,
      );
    }
    emit(
      state.copyWith(
        items: items,
        status: CartStatus.idle,
        clearFailure: true,
        clearOrderId: true,
      ),
    );
  }

  void increaseQuantity(String mealId) {
    if (state.status == CartStatus.placingOrder) return;
    final items = List<CartItem>.of(state.items);
    final index = items.indexWhere((item) => item.meal.id == mealId);
    if (index == -1) return;
    items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    emit(
      state.copyWith(
        items: items,
        status: CartStatus.idle,
        clearFailure: true,
        clearOrderId: true,
      ),
    );
  }

  Future<void> placeOrder(PaymentMethod paymentMethod) async {
    if (state.items.isEmpty || state.status == CartStatus.placingOrder) return;

    final items = List<CartItem>.unmodifiable(state.items);
    final total = state.total;
    final payment = paymentMethod.process(total);
    emit(state.copyWith(status: CartStatus.placingOrder, clearFailure: true));

    final result = await _placeOrder(
      items: items,
      total: total,
      payment: payment,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(status: CartStatus.failure, failure: failure),
      ),
      (orderId) => emit(
        CartState(
          status: CartStatus.placed,
          orderId: orderId,
        ),
      ),
    );
  }
}
