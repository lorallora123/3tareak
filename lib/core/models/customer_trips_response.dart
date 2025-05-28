import 'package:take_me_with_you/core/models/order_response.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
import 'package:take_me_with_you/core/models/vehicle_response.dart';

class CustomerTripsResponse {
  List<CustomerTripDataResponse>? customerTrips;

  CustomerTripsResponse(this.customerTrips);

  factory CustomerTripsResponse.fromJson(Map<String, dynamic> json) {
    return CustomerTripsResponse(
      (json['user_trips'] as List<dynamic>?)
          ?.map((e) =>
              CustomerTripDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_trips': customerTrips?.map((e) => e.toJson()).toList(),
    };
  }
}

class CustomerTripDataResponse {
  int? id;
  int? userId;
  int? orderId;
  int? seatNumber;
  String? from;
  String? to;
  String? distance;
  String? price;
  String? status;
  String? reason;
  String? createdAt;
  double? lat;
  double? lng;
  String? updatedAt;
  OrderDataResponse? order;
  VehicleDataResponse? vehicle;
  UserDataResponse? customer;

  CustomerTripDataResponse({
    this.id,
    this.userId,
    this.orderId,
    this.seatNumber,
    this.from,
    this.to,
    this.distance,
    this.price,
    this.status,
    this.lat,
    this.lng,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.vehicle,
    this.customer,
  });

  factory CustomerTripDataResponse.fromJson(Map<String, dynamic> json) {
    return CustomerTripDataResponse(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      seatNumber: json['seat_number'] ?? 0,
      lat: json['lat'] ?? 0,
      lng: json['lng'] ?? 0,
      from: json['order_from_place'] ?? '',
      to: json['order_to_place'] ?? '',
      distance: json['distance'] ?? '',
      price: json['price'] ?? '',
      status: json['status'] ?? '',
      reason: json['reason'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      order: json['order'] != null
          ? OrderDataResponse.fromJson(json['order'])
          : null,
      vehicle: json['vehicle'] != null
          ? VehicleDataResponse.fromJson(json['vehicle'])
          : null,
      customer:
          json['user'] != null ? UserDataResponse.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_id': orderId,
      'seat_number': seatNumber,
      'order_from_place': from,
      'order_to_place': to,
      'distance': distance,
      'price': price,
      'status': status,
      'reason': reason,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'order': order?.toJson(),
      'vehicle': vehicle?.toJson(),
      'user': customer?.toJson(),
    };
  }
}
