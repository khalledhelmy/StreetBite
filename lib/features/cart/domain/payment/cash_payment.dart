import 'package:street_bite/features/cart/domain/entities/payment_result.dart';
import 'package:street_bite/features/cart/domain/payment/payment_method.dart';

class CashPayment implements PaymentMethod {
  const CashPayment();

  @override
  String get id => 'cash';

  @override
  String get labelKey => 'cart.cash_on_delivery';

  @override
  PaymentResult process(double amount) => PaymentResult(
    method: id,
    status: 'pay_on_delivery',
    amount: amount,
  );
}
