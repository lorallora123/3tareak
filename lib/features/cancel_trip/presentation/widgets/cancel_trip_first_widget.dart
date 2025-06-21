import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/cancel_trip/presentation/getx/cancel_trip_controller.dart';

class CancelTripFirstWidget extends GetView<CancelTripController> {
  const CancelTripFirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(IconsAssets.cancelTrip),
        20.verticalSpace,
        CustomText(
            text: el.tr(AppStrings.areYouSureYouWantToCancelTheTrip),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 19.sp)),
        14.verticalSpace,
        CustomText(
            text: el.tr(AppStrings.cancelDescription),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 12.sp)),
        34.verticalSpace,
        AppButton(
          text: el.tr(AppStrings.confirmation),
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: ColorManager.white),
          onTap: controller.goToSecond,
          color: ColorManager.primary,
          borderRadios: AppSize.s30,
          width: 253.w,
          height: 53.h,
        ),
        29.verticalSpace,
        GestureDetector(
          onTap: () => Get.back(),
          child: CustomText(
              text: el.tr(AppStrings.canceled),
              style: Theme.of(context).textTheme.displayLarge!),
        )
      ],
    );
  }
}
