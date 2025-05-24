import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/app_image.dart';
import 'package:take_me_with_you/core/widgets/custom_rating.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

import 'getx/rate_customer_controller.dart';

class RateCustomerDialog extends GetView<RateCustomerController> {
  const RateCustomerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            width: 320.w,
            height: 320.h,
            padding: EdgeInsets.only(
                top: 32.h, bottom: 71.h, left: 51.w, right: 51.w),
            decoration: const BoxDecoration(
                color: ColorManger.white, shape: BoxShape.circle),
            child: Column(
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s100),
                      child: AppImage(
                        imageUrl: controller.userModel.image ?? '',
                        boxFit: BoxFit.cover,
                      )),
                ),
                16.verticalSpace,
                CustomText(
                    text: el.tr(AppStrings.howWasYourExperienceWith),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15.sp)),
                10.verticalSpace,
                CustomText(
                    text: controller.userModel.fullName!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15.sp)),
                25.verticalSpace,
                CustomRating(
                  rate: 3,
                  itemSize: 30.w,
                  readOnly: false,
                  onChange: controller.onChanged,
                )
              ],
            ),
          ),
          26.verticalSpace,
          Obx(
            () => controller.loading
                ? const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: ColorManger.yellowColor),
                  )
                : AppButton(
                    text: el.tr(AppStrings.confirm),
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: ColorManger.white),
                    onTap: controller.rateCustomer,
                    color: ColorManger.yellowColor,
                    borderRadios: AppSize.s30,
                    width: 253.w,
                    height: 53.h,
                  ),
          )
        ],
      ),
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    );
  }
}
