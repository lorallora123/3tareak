class SpinRequest {
  final double spin;
  final String type;

  SpinRequest({required this.spin, required this.type});

  Map<String, dynamic> toJson() {
    return {
      'value': spin,
      'type': type,
    };
  }
}
