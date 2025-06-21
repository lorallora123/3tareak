import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/app_back_button.dart';
import 'package:take_me_with_you/core/widgets/custom_swipe_buttons/vertical_swipe_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/getx/on_going_trip_controller.dart';

class FinishTripPage extends GetView<OnGoingTripController> {
  const FinishTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ColorManager.white,
          width: 1.sw,
          height: 1.sh,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            IconsAssets.finishTripBackground,
            fit: BoxFit.cover,
            width: 395.w,
            height: 708.h,
          ),
        ),
        SizedBox(
          width: 1.sw,
          child: Column(
            children: [
              88.verticalSpace,
              Icon(
                Icons.keyboard_arrow_up,
                color: ColorManager.primary,
                size: 30.w,
              ),
              SvgPicture.asset(
                IconsAssets.finishTripArrow,
                fit: BoxFit.fitHeight,
                width: 5.w,
                height: 495.h,
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 76.w,
            leading: Row(
              children: [22.horizontalSpace, const AppBackButton()],
            ),
          ),
          body: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Stack(
              children: [
                Column(
                  children: [
                    const Spacer(),
                    Center(
                      child: CustomText(
                          text: el.tr(AppStrings.swipeUpToEndTheTrip),
                          style: Theme.of(context).textTheme.titleLarge!),
                    ),
                    37.verticalSpace
                  ],
                ),
                Positioned(
                  right: 140.16.w,
                  top: 530.h,
                  child: VerticalSwipeButton(
                      onAnimationEnd: controller.captainFinishOrder),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
