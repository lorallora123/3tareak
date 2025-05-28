import '../../data/models/user_coupon_response.dart';

sealed class MyCouponState {}

final class MyCouponInitial extends MyCouponState {}

class MyCouponLoadingState extends MyCouponState {}

class MyCouponSuccessState extends MyCouponState {
  final List<UserCouponResponse> coupons;

  MyCouponSuccessState({required this.coupons});
}


class MyCouponFailState extends MyCouponState {
  final String message;

  MyCouponFailState({required this.message});
}
