import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/app_back_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/on_boarding/getx/on_boarding_controller.dart';

class OnBoardingBackButton extends GetView<OnBoardingController> {
  const OnBoardingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.0.w),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (controller.pageIndex != 0)
              AppBackButton(
                onTap: controller.onTapBackButton,
              )
            else
              const SizedBox(),
            if (controller.pageIndex != 2)
              GestureDetector(
                onTap: controller.onTapSkipButton,
                child: CustomText(
                    text: el.tr(AppStrings.skip),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15.sp)),
              )
          ],
        ),
      ),
    );
  }
}
