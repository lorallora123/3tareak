import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

import '../getx/live_trip_controller.dart';

class RateCaptainView extends GetView<LiveTripController> {
  const RateCaptainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            Positioned(
              top: 100,
              right: 50,
              child: Image.asset(ImageAssets.rateCaptain),
            ),
            PositionedDirectional(
              bottom: 270,
              start: 100,
              child: CustomText(
                text: "كيف كانت تجربتك مع ؟",
                style: Get.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            PositionedDirectional(
              bottom: 220,
              start: 140,
              child: CustomText(
                text: "محمد عدنان",
                style: Get.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            // PositionedDirectional(
            //   bottom: 140,
            //   start: 100,
            //   child: CustomRating(
            //     rate: 5,
            //     itemSize: 35.w,
            //     onChange: controller.onChanged,
            //   ),
            // ),
            PositionedDirectional(
              bottom: 50,
              start: 70,
              child: AppButton(
                text: el.tr(AppStrings.done),
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: ColorManager.yellowColor),
                onTap: () => Get.back(),
                color: ColorManager.iconLightGreyColor,
                borderRadios: AppSize.s30,
                width: 253.w,
                height: 53.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
