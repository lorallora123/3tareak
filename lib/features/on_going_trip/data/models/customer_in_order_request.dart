class CustomerInOrderRequest {
  int? orderId;
  int? customerId;

  CustomerInOrderRequest({required this.orderId, required this.customerId});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': customerId,
    };
  }
}
