class CancelCustomerOrderRequest {
  int id;
  String reason;

  CancelCustomerOrderRequest(this.id, this.reason);
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'reason': reason,
    };
  }
}
