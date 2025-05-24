class PaymentRequest {
  int orderId;
  String customerMSISDN;

  PaymentRequest({
    required this.orderId,
    required this.customerMSISDN,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'order_id': orderId,
      'customerMSISDN': customerMSISDN,
    };
  }
}
