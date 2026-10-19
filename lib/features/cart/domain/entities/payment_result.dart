class PaymentResult {
  const PaymentResult({
    required this.method,
    required this.status,
    required this.amount,
  });

  final String method;
  final String status;
  final double amount;

  Map<String, Object> toJson() => {
    'method': method,
    'status': status,
    'amount': amount,
  };
}
