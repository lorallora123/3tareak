import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/live_customer_trip/presentation/getx/live_trip_controller.dart';

import '../drop_down/app_drop_down.dart';

class CancelOrder extends GetView<LiveTripController> {
  const CancelOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 300.h,
      child: Obx(
        () =>
            !controller.needCancel ? buildConfirmCancel() : buildCancelReason(),
      ),
    );
  }

  Widget buildConfirmCancel() {
    return Column(
      children: [
        70.verticalSpace,
        CustomText(
          text: "هل أنت متأكد من انك تريد إلغاء الطلب ؟",
          style: Get.textTheme.titleLarge!.copyWith(fontSize: 19.sp),
        ),
        40.verticalSpace,
        AppButton(
          text: el.tr(AppStrings.confirmation),
          textStyle:
              Get.textTheme.bodyLarge!.copyWith(color: ColorManager.white),
          onTap: () {
            controller.needCancel = true;
          },
          color: ColorManager.primary,
          borderRadios: AppSize.s30,
          width: 253.w,
          height: 53.h,
        ),
        20.verticalSpace,
        AppButton(
          text: el.tr(AppStrings.canceled),
          textStyle:
              Get.textTheme.bodyLarge!.copyWith(color: ColorManager.primary),
          onTap: () {
            controller.needCancel = false;
            Get.back();
          },
          width: 253.w,
          height: 53.h,
        ),
      ],
    );
  }

  Widget buildCancelReason() {
    return ListView(
      children: [
        40.verticalSpace,
        CustomText(
          text: "سبب إلغاء الطلب ",
          textAlign: TextAlign.center,
          style: Get.textTheme.titleLarge!.copyWith(fontSize: 19.sp),
        ),
        40.verticalSpace,
        Obx(
          () => AppDropDown(
            groupValueTitle: controller.reasonGroupValueTitle,
            groupValue: controller.reasonGroupValue,
            items: controller.reason,
            onChanged: controller.onChangedReasonGroupValue,
            disableOpen: controller.isShowOnly,
          ),
        ),
        20.verticalSpace,
        Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: AppButton(
              text: controller.loadingCancel
                  ? "يتم التأكيد..."
                  : el.tr(AppStrings.confirmation),
              textStyle:
                  Get.textTheme.bodyLarge!.copyWith(color: ColorManager.white),
              onTap: controller.loadingCancel
                  ? null
                  : () {
                      controller.cancelOrder();
                    },
              color: ColorManager.primary,
              borderRadios: AppSize.s30,
              width: 253.w,
              height: 53.h,
            ),
          ),
        ),
        20.verticalSpace,
        AppButton(
          text: el.tr(AppStrings.canceled),
          textStyle:
              Get.textTheme.bodyLarge!.copyWith(color: ColorManager.primary),
          onTap: () {
            controller.needCancel = false;
            Get.back();
          },
          width: 223.w,
          height: 53.h,
        ),
      ],
    );
  }
}
