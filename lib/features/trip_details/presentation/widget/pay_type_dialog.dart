import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

// ignore: must_be_immutable
class PayTypeDialog extends StatelessWidget {
  PayTypeDialog({super.key});
  bool? isCashPressed;
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
                text: "الدفع",
                textAlign: TextAlign.center,
                style: Get.textTheme.displayMedium!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
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
          8.verticalSpace,
          CustomText(
            text: "اختر طريفة الدفع ",
            textAlign: TextAlign.center,
            style: Get.textTheme.displayMedium!
                .copyWith(fontSize: 16.sp, color: ColorManager.iconGreyColor),
          ),
          16.verticalSpace,
          InkWell(
            overlayColor: WidgetStateColor.transparent,
            onTap: () {
              isCashPressed = false;
              controller.update();
              Future.delayed(duration).then((_) async {
                Get.back();
                Get.dialog(const AlertDialog(
                  content: ElectronicPayDialog(),
                ));
                isCashPressed = null;
              });
            },
            child: Container(
              width: double.infinity,
              height: 45.h,
              decoration: BoxDecoration(
                  color: isCashPressed == false
                      ? ColorManager.primary
                      : ColorManager.primaryLight,
                  borderRadius: BorderRadius.circular(25.r)),
              child: Center(
                child: CustomText(
                  text: "دفع إلكتروني",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.displayMedium!.copyWith(
                      fontSize: 16.sp,
                      color:
                          isCashPressed == false ? ColorManager.white : null),
                ),
              ),
            ),
          ),
          10.verticalSpace,
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
              onTap: () async {
                isCashPressed = true;
                controller.update();
                Future.delayed(duration).then((_) async {
                  await controller.joinOrder();
                  isCashPressed = null;
                });
              },
              child: Container(
                width: double.infinity,
                height: 45.h,
                decoration: BoxDecoration(
                    color: isCashPressed == true
                        ? ColorManager.primary
                        : ColorManager.primaryLight,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "دفع كاش",
                        textAlign: TextAlign.center,
                        style: Get.textTheme.displayMedium!.copyWith(
                            fontSize: 16.sp,
                            color: isCashPressed == true
                                ? ColorManager.white
                                : null),
                      ),
                    ],
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
