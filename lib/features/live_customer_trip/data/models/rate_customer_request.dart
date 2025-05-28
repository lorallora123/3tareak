class RateCustomerRequest {
  final int userId;
  final double rate;
  final String type;

  RateCustomerRequest(
      {required this.userId, required this.rate, required this.type});
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'value': rate,
      'type': type,
    };
  }
}
