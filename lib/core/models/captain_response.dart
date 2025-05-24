import 'package:take_me_with_you/core/models/user_response.dart';

class CaptainResponse {
  int? id;
  int? userId;
  String? balance;
  String? additionalAmount;
  String? currentAddress;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  UserDataResponse? user;

  CaptainResponse(
      {this.id,
      this.userId,
      this.balance,
      this.additionalAmount,
      this.currentAddress,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.user});

  factory CaptainResponse.fromJson(Map<String, dynamic> json) {
    return CaptainResponse(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      balance: json['balance'] ?? '',
      additionalAmount: json['additional_amount'] ?? '',
      currentAddress: json['current_address'] ?? '',
      deletedAt: json['deleted_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      user:
          json['user'] == null ? null : UserDataResponse.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'balance': balance,
        'additional_amount': additionalAmount,
        'current_address': currentAddress,
        'deleted_at': deletedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user': user?.toJson(),
      };
}
