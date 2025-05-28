import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/features/my_coupon/data/models/user_coupon_response.dart';
import '../../../../imports.dart';
import 'my_coupon_rep.dart';

class MyCouponRepImpl implements  MyCouponRep {
  final AppPreferences _appPreferences = instance<AppPreferences>();
 final DataService _dataService;

 MyCouponRepImpl(this._dataService);
@override
  Future<Either<Failure, List<UserCouponResponse>>> getMyCoupon() async {
    final int? userId = _appPreferences.getUserId();

    final String endpoint = "${EndPoints.getUserCoupons}/$userId";

    return await _dataService.getData<List<UserCouponResponse>>(
      endPoint: endpoint,
      fromJson: BaseListResponse<UserCouponResponse>.fromJson,
      fromJsonData: (json) =>
          UserCouponResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}