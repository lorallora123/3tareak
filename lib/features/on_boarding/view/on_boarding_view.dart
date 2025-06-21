import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/on_boarding/getx/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) => controller.pages[index],
                itemCount: controller.pages.length),
          ),
          Obx(
            () => CircularPercentIndicator(
                radius: 40.w,
                animation: true,
                animateFromLastPercent: true,
                backgroundColor: Colors.transparent,
                progressColor: ColorManager.primary,
                animationDuration: 1000,
                percent: controller.percent / 3,
                onAnimationEnd: controller.onAnimationEnd,
                center: GestureDetector(
                  onTap: controller.onTapNextButton,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: controller.endPage ? 88.h : 61.h,
                    width: controller.endPage ? 88.w : 61.w,
                    decoration: BoxDecoration(
                        boxShadow: getBoxShadow(),
                        color: controller.endPage
                            ? ColorManager.primary
                            : ColorManager.white,
                        shape: BoxShape.circle),
                    child: Center(
                      child: controller.endPage
                          ? CustomText(
                              text: el.tr(AppStrings.letsGo),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 20.sp))
                          : SvgPicture.asset(IconsAssets.arrowNext),
                    ),
                  ),
                )),
          ),
          65.verticalSpace,
        ],
      ),
    );
  }
}
