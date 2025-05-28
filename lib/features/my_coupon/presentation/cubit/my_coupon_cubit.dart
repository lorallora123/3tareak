import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/di.dart';

import '../../data/repo/my_coupon_rep.dart';
import 'my_coupon_state.dart';

class MyCopounCubit extends Cubit<MyCouponState> {
  MyCopounCubit() : super(MyCouponInitial());
  final MyCouponRep _myCouponRepo = instance<MyCouponRep>();

  Future<void> getMyCoupon() async {
    emit(MyCouponLoadingState());
    (await _myCouponRepo.getMyCoupon()).fold(
      (l) {
        emit(MyCouponFailState(message: l.message));
      },
      (coupons) async {
        emit(MyCouponSuccessState(coupons: coupons));
      },
    );
  }
}
