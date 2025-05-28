class JoinOrderRequest {
  int orderId;
  int seatNumber;
  String from;
  String to;
  double lat;
  double lng;

  JoinOrderRequest({
    this.orderId = 0,
    this.seatNumber = 0,
    this.lat = 0,
    this.lng = 0,
    this.from = '',
    this.to = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'seat_number': seatNumber,
      'from': from,
      'to': to,
      'lat': lat,
      'lng': lng,
    };
  }
}
