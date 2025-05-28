import 'coupon_response.dart';

class UserCouponResponse {
  int? id;
  int? userId;
  int? couponId;
  String? usedAt;
  int? winBySp;
  String? createdAt;
  String? updatedAt;
  CouponResponse? coupon;

  UserCouponResponse({
    this.id,
    this.userId,
    this.couponId,
    this.usedAt,
    this.winBySp,
    this.createdAt,
    this.updatedAt,
    this.coupon,
  });

  factory UserCouponResponse.fromJson(Map<String, dynamic> json) {
    return UserCouponResponse(
      id: json['id'],
      userId: json['user_id'],
      couponId: json['coupon_id'],
      usedAt: json['used_at'],
      winBySp: json['win_by_sp'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      coupon: json['coupon'] != null
          ? CouponResponse.fromJson(json['coupon'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'coupon_id': couponId,
        'used_at': usedAt,
        'win_by_sp': winBySp,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'coupon': coupon?.toJson(),
      };
}
