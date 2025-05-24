import 'package:take_me_with_you/core/models/trip_response.dart';

class CaptainTripsResponse {
  TripDataResponse? order;
  int? availableSeats;

  CaptainTripsResponse(this.order, this.availableSeats);

  factory CaptainTripsResponse.fromJson(Map<String, dynamic> json) {
    return CaptainTripsResponse(
      json['order'] != null ? TripDataResponse.fromJson(json['order']) : null,
      json['availableseats'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order?.toJson(),
      'availableseats': availableSeats,
    };
  }
}
