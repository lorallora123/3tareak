import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/on_boarding/widget/on_boarding_back_button.dart';


class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 156.h, child: SvgPicture.asset(IconsAssets.rightLine)),
        Positioned(
            top: 157.h, left: 41.w, width: 306.w, height: 218.h, child: SvgPicture.asset(IconsAssets.onBoarding2)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.verticalSpace,
            const OnBoardingBackButton(),
            353.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0.w),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 212.w,
                    height: 15.h,
                    color: ColorManger.primary.withOpacity(0.6),
                  ),
                  CustomText(
                      text: el.tr(AppStrings.onBoardingTitle2),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24.sp)),
                ],
              ),
            ),
            34.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0.w),
              child: CustomText(
                  textAlign: TextAlign.center,
                  text: el.tr(AppStrings.onBoardingBody2),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15.sp)),
            )
          ],
        )
      ],
    );
  }
}
