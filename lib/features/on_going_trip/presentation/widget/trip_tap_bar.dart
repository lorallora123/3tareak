import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/getx/on_going_trip_controller.dart';

class TripTabBar extends GetView<OnGoingTripController> {
  final int index;

  const TripTabBar({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectIndex(index),
        child: Container(
          height: 44.h,
          margin: EdgeInsets.only(left: 13.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: index == controller.indexPage
                  ? ColorManager.primary
                  : ColorManager.lightPrimary,
              borderRadius: BorderRadius.circular(AppSize.s30)),
          child: index == 0
              ? CustomText(
                  text: el.tr(AppStrings.detailsOfTheTrip),
                  style: index == controller.indexPage
                      ? Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15.sp)
                      : Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 15.sp))
              : Row(
                  children: [
                    SvgPicture.asset(
                      IconsAssets.seats,
                      // ignore: deprecated_member_use
                      color: index == controller.indexPage
                          ? ColorManager.white
                          : ColorManager.primary,
                      width: 14.w,
                      height: 20.h,
                    ),
                    12.horizontalSpace,
                    CustomText(
                        text: "${el.tr(AppStrings.order)} $index",
                        style: index == controller.indexPage
                            ? Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 15.sp)
                            : Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 15.sp))
                  ],
                ),
        ),
      ),
    );
  }
}
