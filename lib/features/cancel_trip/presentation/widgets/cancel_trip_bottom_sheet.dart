import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/features/cancel_trip/presentation/getx/cancel_trip_controller.dart';

import 'cancel_trip_first_widget.dart';
import 'cancel_trip_second_widget.dart';

class CancelTripBottomSheet extends GetView<CancelTripController> {
  const CancelTripBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 356.w,
          height: controller.isFirst ? 434.h : 252.h,
          padding:
              EdgeInsets.only(top: 42.h, right: 29.w, left: 29.w, bottom: 19.h),
          decoration: const BoxDecoration(
              color: ColorManger.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s30),
                  topRight: Radius.circular(AppSize.s30))),
          child: controller.isFirst
              ? const CancelTripFirstWidget()
              : const CancelTripSecondWidget(),
        ),
      ),
    );
  }
}
