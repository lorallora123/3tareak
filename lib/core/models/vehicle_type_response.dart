class VehicleTypeResponse {
  List<VehicleTypeDataResponse>? vehicleTypes;

  VehicleTypeResponse({this.vehicleTypes});

  factory VehicleTypeResponse.fromJson(Map<String, dynamic> json) {
    return VehicleTypeResponse(
      vehicleTypes: (json['vehicle_types'] as List<dynamic>?)
          ?.map((e) =>
              VehicleTypeDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_types': vehicleTypes?.map((e) => e.toJson()).toList(),
    };
  }
}

class VehicleTypeDataResponse {
  int? id;
  String? type;
  String? pricePerKilo;
  String? companyPercentage;
  String? createdAt;
  String? updatedAt;
  String? image;

  VehicleTypeDataResponse({
    this.id,
    this.type,
    this.pricePerKilo,
    this.companyPercentage,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory VehicleTypeDataResponse.fromJson(Map<String, dynamic> json) {
    return VehicleTypeDataResponse(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      pricePerKilo: json['price_per_kilo'] ?? '',
      companyPercentage: json['company_percentage'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'price_per_kilo': pricePerKilo,
      'company_percentage': companyPercentage,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image': image,
    };
  }
}
