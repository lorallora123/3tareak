class PaymentResponse {
  String? transactionId;

  PaymentResponse({this.transactionId});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(transactionId: json['transactionID'] as String?);
  }
}
