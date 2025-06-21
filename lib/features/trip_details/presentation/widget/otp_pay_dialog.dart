import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:take_me_with_you/imports.dart';

class OtpPayDialog extends StatelessWidget {
  const OtpPayDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripDetailsController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              16.horizontalSpace,
              CustomText(
                text: "ادخل رمز التأكيد",
                textAlign: TextAlign.center,
                style: Get.textTheme.displayMedium!.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 12.h,
                  ),
                ),
              ),
            ],
          ),
          40.verticalSpace,
          Builder(builder: (context) {
            final defaultPinTheme = PinTheme(
              decoration: BoxDecoration(
                border: Border.merge(
                  const Border(bottom: BorderSide(color: ColorManager.primary)),
                  const Border(
                    bottom: BorderSide(
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ),
              height: 30.h,
              width: 100.w,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              textStyle: TextStyle(
                fontSize: 22.sp,
                color: ColorManager.black,
              ),
            );
            return CustomOtp(defaultPinTheme: defaultPinTheme);
          }),
          40.verticalSpace,
          GetBuilder<TripDetailsController>(builder: (controller) {
            if (controller.loading) {
              return CustomShimmer(
                height: 45.h,
                width: double.infinity,
                raduis: 25.r,
              );
            }
            return InkWell(
              overlayColor: WidgetStateColor.transparent,
              onTap: () async {},
              child: Container(
                width: double.infinity,
                height: 45.h,
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Center(
                  child: CustomText(
                    text: "تأكيد",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.displayMedium!
                        .copyWith(fontSize: 16.sp, color: ColorManager.white),
                  ),
                ),
              ),
            );
          }),
          16.verticalSpace,
        ],
      );
    });
  }
}
