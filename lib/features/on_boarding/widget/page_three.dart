import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/on_boarding/widget/on_boarding_back_button.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 171.h, child: SvgPicture.asset(IconsAssets.bottomRightLine)),
        Positioned(
            top: 373.h,
            left: 28.w,
            width: 334.w,
            height: 277.h,
            child: SvgPicture.asset(IconsAssets.onBoarding3)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.verticalSpace,
            const OnBoardingBackButton(),
            64.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 204.w,
                    height: 15.h,
                    color: ColorManager.primary.withOpacity(0.6),
                  ),
                  CustomText(
                      text: el.tr(AppStrings.onBoardingTitle3),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 24.sp)),
                ],
              ),
            ),
            34.verticalSpace,
            Padding(
              padding: EdgeInsets.only(right: 36.w, left: 72.w),
              child: CustomText(
                  textAlign: TextAlign.center,
                  text: el.tr(AppStrings.onBoardingBody3),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            )
          ],
        )
      ],
    );
  }
}
