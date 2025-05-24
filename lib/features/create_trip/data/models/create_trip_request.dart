class CreateTripRequest {
  final String startedAt;
  final int? vehicleId;
  final String fromPlace;
  final String toPlace;
  final double lat1;
  final double lng1;
  final double lat2;
  final double lng2;
  final String seatNumber;
  final String? notes;
  final String distance;
  final String? tripFor;
  final String? polyline;

  CreateTripRequest({
    required this.startedAt,
    required this.vehicleId,
    required this.fromPlace,
    required this.toPlace,
    required this.lat1,
    required this.lng1,
    required this.lat2,
    required this.lng2,
    required this.seatNumber,
    required this.notes,
    required this.distance,
    required this.tripFor,
    required this.polyline,
  });

  Map<String, dynamic> toJson() => {
        'started_at': startedAt,
        'vehicle_id': vehicleId,
        'from_place': fromPlace,
        'to_place': toPlace,
        'lat1': lat1,
        'lng1': lng1,
        'lat2': lat2,
        'lng2': lng2,
        'seat_number': seatNumber,
        'notes': notes,
        'distance': distance,
        'trip_for': tripFor,
        'polyline': polyline?.trim(),
      };
  Map<String, dynamic> privateToJson() => {
        'started_at': startedAt,
        'from_place': fromPlace,
        'to_place': toPlace,
        'lat1': lat1,
        'lng1': lng1,
        'lat2': lat2,
        'lng2': lng2,
        'seat_number': seatNumber,
        'distance': distance,
        'polyline': polyline?.trim(),
        // 'notes': notes,
        // 'vehicle_id': vehicleId,
        // 'trip_for': tripFor,
      };
}
