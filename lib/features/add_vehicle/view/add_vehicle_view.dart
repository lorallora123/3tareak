import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class AddVehicleView extends GetView<AddVehicleController> {
  const AddVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddVehicleAppBar(),
      body: Form(
        key: controller.form2Key,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              62.verticalSpace,
              Obx(
                () => AppDropDown(
                  title: el.tr(AppStrings.vehicleType),
                  groupValueTitle: controller.vehicleGroupValueTitle,
                  icon: IconsAssets.vehicleType,
                  groupValue: controller.vehicleGroupValue,
                  items: controller.vehicle,
                  onChanged: controller.onChangedVehicleGroupValue,
                  disableOpen: controller.isShowOnly,
                ),
              ),
              AppTextFiled(
                isSvg: true,
                textStyle: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 15.sp),
                controller: controller.modelController,
                textAlign: TextAlign.end,
                svgPrefixIcon: IconsAssets.vehicleModel,
                suffixText: "${el.tr(AppStrings.vehicleModel)} :",
                label: "${el.tr(AppStrings.vehicleModel)} :",
                enabled: !controller.isShowOnly,
                validator: valid,
              ),
              20.verticalSpace,
              AppTextFiled(
                isSvg: true,
                keyboardType: TextInputType.text,
                textStyle: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 15.sp),
                textAlign: TextAlign.end,
                svgPrefixIcon: IconsAssets.vehicleColor,
                controller: controller.colorGroupValue,
                action: TextInputAction.next,
                suffixText: "${el.tr(AppStrings.vehicleColor)} :",
                label: "${el.tr(AppStrings.vehicleColor)} :",
                enabled: !controller.isShowOnly,
                validator: valid,
              ),
              10.verticalSpace,
              AppTextFiled(
                isSvg: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textStyle: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 15.sp),
                textAlign: TextAlign.end,
                svgPrefixIcon: IconsAssets.vehicleId,
                controller: controller.vehicleIdController,
                action: TextInputAction.next,
                suffixText: "${el.tr(AppStrings.vehicleId)} :",
                label: "${el.tr(AppStrings.vehicleId)} :",
                enabled: !controller.isShowOnly,
                validator: valid,
              ),
              10.verticalSpace,
              AppTextFiled(
                isSvg: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // Only allow digits
                textStyle: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 15.sp),
                textAlign: TextAlign.end,
                svgPrefixIcon: IconsAssets.seats,
                controller: controller.seatsNumberController,
                suffixText: "${el.tr(AppStrings.numberOfSeats)} :",
                label: "${el.tr(AppStrings.numberOfSeats)} :",
                enabled: !controller.isShowOnly,
                validator: valid,
              ),
              if (controller.isShowOnly) ...[
                21.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(right: 14.w, left: 10.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconsAssets.price,
                        width: 21.297443389892578.w,
                        height: 14.868025779724121.h,
                      ),
                      11.horizontalSpace,
                      CustomText(
                          text: el.tr(AppStrings.pricePerKilo),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp)),
                      const Spacer(),
                      CustomText(
                          text:
                              "1/${el.tr(AppStrings.km)} ${controller.model!.type!.pricePerKilo} ${el.tr(AppStrings.sp)}",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 15.sp)),
                    ],
                  ),
                ),
                18.verticalSpace,
                const Divider(
                  color: ColorManager.borderGreyColor,
                ),
                21.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(right: 14.w, left: 10.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconsAssets.percent,
                        width: 16.w,
                        height: 15.h,
                      ),
                      11.horizontalSpace,
                      CustomText(
                          text: el.tr(AppStrings.companyRatio),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp)),
                      const Spacer(),
                      CustomText(
                          text:
                              "${controller.model!.type!.companyPercentage} %",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 15.sp)),
                    ],
                  ),
                ),
                18.verticalSpace,
                const Divider(
                  color: ColorManager.borderGreyColor,
                )
              ],
              33.verticalSpace,
              const VehicleImageList(),
              150.verticalSpace
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? const SizedBox.shrink()
          : Obx(
              () => controller.loading
                  ? const CircularProgressIndicator()
                  : !controller.isShowOnly
                      ? AppButton(
                          text: el.tr(AppStrings.addVehicle),
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: ColorManager.white),
                          onTap: controller.addVehicle,
                          color: ColorManager.blackText,
                          borderRadios: AppSize.s30,
                          width: 346.w,
                          height: 53.h,
                        )
                      : const SizedBox.shrink(),
            ),
    );
  }
}
