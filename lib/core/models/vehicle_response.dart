import 'package:take_me_with_you/core/models/vehicle_type_response.dart';

class VehicleResponse {
  List<VehicleDataResponse>? vehicles;

  VehicleResponse(this.vehicles);

  factory VehicleResponse.fromJson(Map<String, dynamic> json) {
    return VehicleResponse(
      (json['vehicles'] as List<dynamic>?)
          ?.map((e) => VehicleDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicles': vehicles?.map((e) => e.toJson()).toList(),
    };
  }
}

class VehicleDataResponse {
  int? id;
  int? vehicleTypeId;
  int? userId;
  String? model;
  String? color;
  int? boardNumber;
  String? vehicleImage;
  String? mechanicImage;
  String? boardImage;
  String? idImage;
  String? delegateImage;
  int? verified;
  String? createdAt;
  String? updatedAt;
  VehicleTypeDataResponse? type;
  int? seatNumber;

  VehicleDataResponse({
    this.id,
    this.vehicleTypeId,
    this.userId,
    this.boardNumber,
    this.verified,
    this.updatedAt,
    this.createdAt,
    this.color,
    this.vehicleImage,
    this.boardImage,
    this.delegateImage,
    this.idImage,
    this.mechanicImage,
    this.model,
    this.type,
    this.seatNumber,
  });

  factory VehicleDataResponse.fromJson(Map<String, dynamic> json) {
    return VehicleDataResponse(
      id: json['id'] ?? 0,
      vehicleTypeId: json['vehicle_type_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      model: json['model'] ?? '',
      color: json['color'] ?? '',
      boardNumber: json['board_number'] ?? 0,
      vehicleImage: json['vehicle_image'] ?? '',
      mechanicImage: json['mechanic_image'] ?? '',
      boardImage: json['board_image'] ?? '',
      idImage: json['id_image'] ?? '',
      delegateImage: json['delegate_image'] ?? '',
      verified: json['verified'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      type: json['type'] != null
          ? VehicleTypeDataResponse.fromJson(json['type'])
          : null,
      seatNumber: json['seat_number'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle_type_id': vehicleTypeId,
      'user_id': userId,
      'model': model,
      'color': color,
      'board_number': boardNumber,
      'vehicle_image': vehicleImage,
      'mechanic_image': mechanicImage,
      'board_image': boardImage,
      'id_image': idImage,
      'delegate_image': delegateImage,
      'verified': verified,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type': type?.toJson(),
      'seat_number': seatNumber,
    };
  }
}
