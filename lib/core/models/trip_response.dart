import 'package:take_me_with_you/core/models/captain_response.dart';
import 'package:take_me_with_you/core/models/customer_trips_response.dart';
import 'package:take_me_with_you/core/models/vehicle_response.dart';

class TripResponse {
  List<TripDataResponse>? captainOrders;

  TripResponse(this.captainOrders);

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    return TripResponse(
      (json['captin_orders'] as List<dynamic>?)
          ?.map((e) => TripDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'captin_orders': captainOrders?.map((e) => e.toJson()).toList(),
    };
  }
}

class TripListByDateResponse {
  Map<String, List<TripDataResponse>>? captainOrders;

  TripListByDateResponse(this.captainOrders);

  factory TripListByDateResponse.fromJson(Map<String, dynamic> json) {
    return TripListByDateResponse(
      (json['captin_orders'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>)
              .map((e) => TripDataResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'captin_orders': captainOrders?.map(
        (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList()),
      ),
    };
  }
}

class TripDateResponseUserTrip {
  TripDataResponse? trip;

  TripDateResponseUserTrip(this.trip);

  factory TripDateResponseUserTrip.fromJson(Map<String, dynamic> json) {
    return TripDateResponseUserTrip(
      json['user_trip'] != null
          ? TripDataResponse.fromJson(json['user_trip'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_trip': trip?.toJson(),
    };
  }
}

class TripDataResponse {
  int? id;
  int? captainId;
  int? vehicleId;
  String? fromPlace;
  String? toPlace;
  String? distance;
  String? startedAt;
  int? seatNumber;
  int? total;
  int? companyProfit;
  int? captainProfit;
  String? notes;
  String? status;
  String? reason;
  RateResponse? rate;
  String? createdAt;
  String? reservedSeats;
  String? updatedAt;
  VehicleDataResponse? vehicle;
  List<CustomerTripDataResponse>? customers;
  CaptainResponse? captain;

  TripDataResponse({
    this.id,
    this.captainId,
    this.vehicleId,
    this.fromPlace,
    this.toPlace,
    this.distance,
    this.startedAt,
    this.reservedSeats,
    this.seatNumber,
    this.total,
    this.companyProfit,
    this.captainProfit,
    this.notes,
    this.rate,
    this.status,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.vehicle,
    this.captain,
    this.customers,
  });

  factory TripDataResponse.fromJson(Map<String, dynamic> json) {
    return TripDataResponse(
      id: json['id'] ?? 0,
      captainId: json['captin_id'] ?? 0,
      vehicleId: json['vehicle_id'] ?? 0,
      fromPlace: json['from_place'] ?? '',
      toPlace: json['to_place'] ?? '',
      distance: json['distance'] ?? '',
      startedAt: json['started_at'] ?? '',
      seatNumber: json['seat_number'] ?? 0,
      total: json['total'] ?? 0,
      companyProfit: json['company_profit'] ?? 0,
      captainProfit: json['captin_profit'] ?? 0,
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
      reason: json['reason'] ?? '',
      rate: json['rate'] != null ? RateResponse.fromJson(json['rate']) : null,
      createdAt: json['created_at'] ?? '',
      reservedSeats: json['reserved_seats'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      vehicle: json['vehicle'] != null
          ? VehicleDataResponse.fromJson(json['vehicle'])
          : null,
      customers: (json['trips'] as List<dynamic>?)
          ?.map((e) =>
              CustomerTripDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      captain: json['captin'] != null
          ? CaptainResponse.fromJson(json['captin'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'captin_id': captainId,
      'vehicle_id': vehicleId,
      'from_place': fromPlace,
      'to_place': toPlace,
      'distance': distance,
      'started_at': startedAt,
      'seat_number': seatNumber,
      'total': total,
      'company_profit': companyProfit,
      'captin_profit': captainProfit,
      'notes': notes,
      'status': status,
      'reason': reason,
      'rate': rate?.toJson(),
      'created_at': createdAt,
      'reserved_seats': reservedSeats,
      'updated_at': updatedAt,
      'vehicle': vehicle?.toJson(),
      'trips': customers?.map((e) => e.toJson()).toList(),
      'captin': captain?.toJson(),
    };
  }
}

class RateResponse {
  int? id;
  int? userId;
  int? raterId;
  String? createdAt;
  String? updatedAt;
  num? rate;

  RateResponse({
    this.id,
    this.userId,
    this.raterId,
    this.createdAt,
    this.updatedAt,
    this.rate,
  });

  factory RateResponse.fromJson(Map<String, dynamic> json) {
    return RateResponse(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      raterId: json['rater_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      rate: json['rate'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'rater_id': raterId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'rate': rate,
    };
  }
}
