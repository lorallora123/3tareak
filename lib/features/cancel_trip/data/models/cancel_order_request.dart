class CancelOrderRequest {
  int id;
  String reason;

  CancelOrderRequest(this.reason, this.id);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'reason': reason,
    };
  }
}
