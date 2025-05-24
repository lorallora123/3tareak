class RateUsRequest {
  final double rate;
  final String type;

  RateUsRequest({required this.rate, required this.type});

  Map<String, dynamic> toJson() {
    return {
      'value': rate,
      'type': type,
    };
  }
}
