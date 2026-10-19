import 'package:street_bite/features/cart/domain/entities/payment_result.dart';
import 'package:street_bite/features/cart/domain/payment/payment_method.dart';

class CardPayment implements PaymentMethod {
  const CardPayment();

  @override
  String get id => 'card';

  @override
  String get labelKey => 'cart.simulated_card';

  @override
  PaymentResult process(double amount) => PaymentResult(
    method: id,
    status: 'simulated',
    amount: amount,
  );
}
