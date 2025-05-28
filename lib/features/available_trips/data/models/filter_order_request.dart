class FilterOrderRequest {
  List<int> vehicleTypeId;
  String? from;
  String? to;
  int? seatsNum;
  String? date;
  String? time;

  String? tripFor;

  FilterOrderRequest({
    required this.vehicleTypeId,
    this.from,
    this.to,
    this.seatsNum,
    this.date,
    this.time,
    this.tripFor,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'vehicle_type_id': vehicleTypeId,
      'from': from,
      'to': to,
      'seat_number': seatsNum,
      'date': date,
      'time': time,
      'trip_for': tripFor,
    };
  }
}
