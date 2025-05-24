import 'package:take_me_with_you/core/models/captain_response.dart';

class UserResponse {
  UserDataResponse? user;
  String? token;

  UserResponse({this.user, this.token});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: UserDataResponse.fromJson(json['user']),
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'token': token,
      };
}

class UserDataResponse {
  int? id;
  String? fullName;
  String? phoneNumber;
  String? image;
  String? role;
  String? deletedAt;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  int? rateAsCaptain;
  int? rateAsCustomer;
  String? tripStatus;
  CaptainResponse? captain;

  UserDataResponse(
      {this.id,
      this.fullName,
      this.phoneNumber,
      this.image,
      this.role,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.rateAsCustomer,
      this.rateAsCaptain,
      this.tripStatus,
      this.deletedAt,
      this.captain});

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      id: json['id'] ?? 0,
      fullName: json['fullname'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      image: json['image'] ?? '',
      role: json['role'] ?? '',
      deletedAt: json['deleted_at'] ?? '',
      rememberToken: json['remember_token'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      rateAsCaptain: json['userRating'] ?? 0,
      rateAsCustomer: json['customerRating'] ?? 0,
      tripStatus: json['tripStatus'] ?? '',
      captain: json['captin'] == null
          ? null
          : CaptainResponse.fromJson(json['captin']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullName,
        'phone_number': phoneNumber,
        'image': image,
        'role': role,
        'deleted_at': deletedAt,
        'remember_token': rememberToken,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'userRating': rateAsCaptain,
        'customerRating': rateAsCustomer,
        'tripStatus': tripStatus,
        'captin': captain?.toJson(),
      };
}
