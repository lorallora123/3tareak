import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class VehicleItem extends GetView<VehicleSelectionController> {
  final VehicleDataResponse model;
  final Function() onDetailsTap;
  const VehicleItem(
      {required this.onDetailsTap, required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 243.w,
        margin: EdgeInsets.only(bottom: 26.h),
        padding:
            EdgeInsets.only(top: 22.h, bottom: 10.h, right: 14.w, left: 15.w),
        decoration: BoxDecoration(
            color: ColorManger.white,
            boxShadow: [
              BoxShadow(
                  color: ColorManger.black.withOpacity(0.12), blurRadius: 16)
            ],
            borderRadius: BorderRadius.circular(AppSize.s30),
            border: Border.all(
                color: controller.selectedVehicle.value.id == model.id
                    ? ColorManger.primary
                    : ColorManger.white,
                width: 3)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 34.w, left: 9.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: model.model ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 13.sp)),
                  Container(
                    width: 64.w,
                    height: 64.h,
                    decoration: const BoxDecoration(
                        color: ColorManger.circleGreyColor,
                        shape: BoxShape.circle),
                    child: Center(
                      child: AppImage(
                          imageUrl: model.type?.image ?? '',
                          boxFit: BoxFit.cover),
                    ),
                  )
                ],
              ),
            ),
            if (model.type != null) ...[
              11.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "${el.tr(AppStrings.pricePerKilo)} :",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 13.sp)),
                  CustomText(
                      text:
                          "1/${el.tr(AppStrings.km)} ${model.type!.pricePerKilo} ${el.tr(AppStrings.sp)}",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 13.sp)),
                ],
              ),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "${el.tr(AppStrings.companyRatio)} :",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 13.sp)),
                  CustomText(
                      text: "${model.type!.companyPercentage} %",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 13.sp)),
                ],
              )
            ],
            15.verticalSpace,
            GestureDetector(
              onTap: onDetailsTap,
              child: Text(
                el.tr(AppStrings.carDetails),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14.sp,
                      color: ColorManger.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorManger.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
