import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;

import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class ElectronicPayDialog extends StatelessWidget {
  const ElectronicPayDialog({super.key});
  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 150);

    return GetBuilder<TripDetailsController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              16.horizontalSpace,
              CustomText(
                text: "ادخل رقم الدفع",
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
          16.verticalSpace,
          Form(
            key: controller.formKey,
            child: AppTextFiled(
              prefixIcon: Icons.call,
              keyboardType: TextInputType.phone,
              validator: validPhoneNumber,
              controller: controller.customerMSISDN,
              label: el.tr(AppStrings.mobileNumber),
            ),
          ),
          24.verticalSpace,
          InkWell(
            overlayColor: WidgetStateColor.transparent,
            onTap: () {
              Future.delayed(duration).then((_) async {
                controller.electronicPayment();
              });
            },
            child: Container(
              width: double.infinity,
              height: 45.h,
              decoration: BoxDecoration(
                  color: ColorManger.primary,
                  borderRadius: BorderRadius.circular(25.r)),
              child: Center(
                child: CustomText(
                  text: "إرسال",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.displayMedium!
                      .copyWith(fontSize: 16.sp, color: ColorManger.white),
                ),
              ),
            ),
          ),
          16.verticalSpace,
        ],
      );
    });
  }
}
