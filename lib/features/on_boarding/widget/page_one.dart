import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/on_boarding/widget/on_boarding_back_button.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 120.h, child: SvgPicture.asset(IconsAssets.leftLine)),
        Positioned(
            top: 440.h, left: 84.w, width: 222.w, height: 209.74.h, child: SvgPicture.asset(IconsAssets.onBoarding1)),
        Column(
          children: [
            50.verticalSpace,
            const OnBoardingBackButton(),
            73.verticalSpace,
            Row(
              children: [
                46.horizontalSpace,
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: 173,
                      height: 15,
                      color: ColorManger.primary.withOpacity(0.6),
                    ),
                    CustomText(
                        text: el.tr(AppStrings.onBoardingTitle1),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24.sp)),
                  ],
                ),
              ],
            ),
            35.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 46.w),
              child: CustomText(
                  text: el.tr(AppStrings.onBoardingBody1),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15.sp)),
            )
          ],
        ),
      ],
    );
  }
}
