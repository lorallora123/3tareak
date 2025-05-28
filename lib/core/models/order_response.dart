import 'package:take_me_with_you/core/models/captain_response.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
import 'package:take_me_with_you/core/models/vehicle_response.dart';
import 'package:take_me_with_you/core/models/vehicle_type_response.dart';

class OrderResponse {
  List<OrderDataResponse>? userOrders;

  OrderResponse({this.userOrders});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      userOrders: (json['userOrders'] as List<dynamic>?)
          ?.map((e) => OrderDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userOrders': userOrders?.map((e) => e.toJson()).toList(),
    };
  }
}

class CustomerOrderResponse {
  OrderDataResponse? customerTrip;

  CustomerOrderResponse(this.customerTrip);

  factory CustomerOrderResponse.fromJson(Map<String, dynamic> json) {
    return CustomerOrderResponse(
      json['user_trip'] != null
          ? OrderDataResponse.fromJson(json['user_trip'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_trip': customerTrip?.toJson(),
    };
  }
}

class CustomerOrder {
  int? id;
  int? orderId;
  int? vehicleId;
  String? fromPlace;
  String? toPlace;
  String? distance;
  String? price;
  String? status;
  String? reason;
  int? seatNumber;
  OrderDataResponse? order;
  UserDataResponse? user;

  CustomerOrder({
    this.id,
    this.vehicleId,
    this.fromPlace,
    this.toPlace,
    this.seatNumber,
    this.orderId,
    this.order,
    this.user,
    this.distance,
    this.price,
    this.status,
    this.reason,
  });

  factory CustomerOrder.fromJson(Map<String, dynamic> json) {
    return CustomerOrder(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      vehicleId: json['vehicle_id'] ?? 0,
      fromPlace: json['from_place'] ?? '',
      toPlace: json['to_place'] ?? '',
      distance: json['distance'] ?? '',
      price: json['price'] ?? '',
      status: json['status'] ?? '',
      reason: json['reason'] ?? '',
      seatNumber: json['seat_number'] ?? 0,
      order: json['order'] != null
          ? OrderDataResponse.fromJson(json['order'])
          : null,
      user:
          json['user'] != null ? UserDataResponse.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'vehicle_id': vehicleId,
      'from_place': fromPlace,
      'to_place': toPlace,
      'distance': distance,
      'price': price,
      'status': status,
      'reason': reason,
      'seat_number': seatNumber,
      'order': order?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class OrderDataResponse {
  int? id;
  int? captainId;
  int? vehicleId;
  String? fromPlace;
  String? toPlace;
  String? startedAt;
  int? seatNumber;
  int? userRecievedAmount;
  double? total;
  String? notes;
  String? status;
  String? reason;
  String? polyline;
  String? createdAt;
  String? updatedAt;
  CaptainResponse? captain;
  VehicleDataResponse? vehicle;
  VehicleTypeDataResponse? vehicleType;
  List<Points>? points;
  String? tripFor;

  OrderDataResponse({
    this.id,
    this.captainId,
    this.vehicleId,
    this.fromPlace,
    this.toPlace,
    this.startedAt,
    this.seatNumber,
    this.total,
    this.notes,
    this.status,
    this.reason,
    this.polyline,
    this.createdAt,
    this.updatedAt,
    this.userRecievedAmount,
    this.captain,
    this.vehicle,
    this.points,
    this.vehicleType,
    this.tripFor,
  });

  factory OrderDataResponse.fromJson(Map<String, dynamic> json) {
    return OrderDataResponse(
      id: json['id'] ?? 0,
      captainId: json['captin_id'] ?? 0,
      fromPlace: json['from_place'] ?? '',
      toPlace: json['to_place'] ?? '',
      startedAt: json['started_at'] ?? '',
      vehicleId: int.tryParse(json['vehicle_id'].toString()) ?? 0,
      seatNumber: int.tryParse(json['seat_number'].toString()) ?? 0,
      userRecievedAmount: json['user_recieved_amount'] ?? 0,
      total: double.tryParse(json['total'].toString()) ?? 0,
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
      reason: json['reason'] ?? '',
      polyline: json['polyline'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      captain: json['captin'] != null
          ? CaptainResponse.fromJson(json['captin'])
          : null,
      vehicle: json['vehicle'] != null
          ? VehicleDataResponse.fromJson(json['vehicle'])
          : null,
      vehicleType: json['vehicle_type'] != null
          ? VehicleTypeDataResponse.fromJson(json['vehicle_type'])
          : null,
      points: (json['points'] as List<dynamic>?)
          ?.map((e) => Points.fromJson(e as Map<String, dynamic>))
          .toList(),
      tripFor: json['trip_for'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'captin_id': captainId,
      'vehicle_id': vehicleId,
      'from_place': fromPlace,
      'to_place': toPlace,
      'started_at': startedAt,
      'seat_number': seatNumber,
      'user_recieved_amount': userRecievedAmount,
      'total': total,
      'notes': notes,
      'status': status,
      'reason': reason,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'captin': captain?.toJson(),
      'vehicle': vehicle?.toJson(),
      'vehicle_type': vehicleType?.toJson(),
      'points': points?.map((e) => e.toJson()).toList(),
      'trip_for': tripFor,
    };
  }
}

class Points {
  final String lat;
  final String lng;
  final String type;

  Points({required this.lat, required this.lng, required this.type});

  factory Points.fromJson(Map<String, dynamic> json) {
    return Points(
      lat: json['lat'] ?? '',
      lng: json['lng'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'type': type,
    };
  }
}
