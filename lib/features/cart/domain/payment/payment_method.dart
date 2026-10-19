import 'package:street_bite/features/cart/domain/entities/payment_result.dart';

abstract interface class PaymentMethod {
  String get id;
  String get labelKey;

  PaymentResult process(double amount);
}
