class PaymentConfirmationRequest {
  String otp;
  String transactionId;

  PaymentConfirmationRequest({
    required this.otp,
    required this.transactionId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'OTP': otp,
      'transactionID': transactionId,
    };
  }
}
