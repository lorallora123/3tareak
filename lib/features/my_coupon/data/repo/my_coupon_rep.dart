import 'package:dartz/dartz.dart';

import '../../../../core/services/failure.dart';
import '../models/user_coupon_response.dart';

abstract class MyCouponRep {
  Future<Either<Failure, List<UserCouponResponse>>> getMyCoupon();
}