import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class FilterTripView extends GetView<AvailableTripsController> {
  const FilterTripView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Get.back(result: 'refresh');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomText(
            text: "فلترة",
            style: Get.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.all(8.w),
            child: AppBackButton(
              onTap: () {
                Get.back(result: 'refresh');
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(IconsAssets.fromToLocation,
                          width: 24.w, height: 91.h),
                      SvgPicture.asset(
                        IconsAssets.threeDot,
                        width: 3.w,
                        height: 16.h,
                      )
                    ],
                  ),
                  21.horizontalSpace,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "${el.tr(AppStrings.from)} :",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: ColorManger.blueColor,
                                        fontSize: 15.sp)),
                            Expanded(child: Obx(() {
                              if (controller.updatePos1Loading) {
                                return locationTextFeildShimmer();
                              }
                              return AppTextFiled(
                                controller: controller.fromController,
                                action: TextInputAction.next,
                                validator: valid,
                                enabled: false,
                              );
                            })),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.selectAddressMapRoute,
                                        arguments: {'isOrigin': true})!
                                    .then((result) {
                                  controller.updatePos1(
                                      Get.find<SelectAddressMapController>()
                                          .origin
                                          .value
                                          .position,
                                      title: result);
                                });
                              },
                              child: GetBuilder<AvailableTripsController>(
                                id: "LAT",
                                builder: (con) {
                                  return CustomText(
                                      text: con.pos1 != null
                                          ? "محدد"
                                          : el.tr(AppStrings.selectOnMap),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(fontSize: 13.sp));
                                },
                              ),
                            ),
                          ],
                        ),
                        21.verticalSpace,
                        const Divider(color: ColorManger.iconLightGreyColor),
                        21.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "${el.tr(AppStrings.to)} :",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: 15.sp)),
                            Expanded(child: Obx(() {
                              if (controller.updatePos2Loading) {
                                return locationTextFeildShimmer();
                              }
                              return AppTextFiled(
                                controller: controller.toController,
                                action: TextInputAction.next,
                                validator: valid,
                                enabled: false,
                              );
                            })),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.selectAddressMapRoute,
                                        arguments: {'isOrigin': false})!
                                    .then((result) {
                                  controller.updatePos2(
                                      Get.find<SelectAddressMapController>()
                                          .destination
                                          .value
                                          .position,
                                      title: result);
                                });
                              },
                              child: GetBuilder<AvailableTripsController>(
                                id: "LAT",
                                builder: (con) {
                                  return CustomText(
                                    text: con.pos2 != null
                                        ? "محدد"
                                        : el.tr(AppStrings.selectOnMap),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: 13.sp),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              30.verticalSpace,
              buildDivider(),
              AppTextFiled(
                label: el.tr('عدد المقاعد المطلوبة'),
                prefixIcon: Icons.person,
                action: TextInputAction.next,
                controller: controller.numSeats,
                keyboardType: TextInputType.number,
              ),
              30.verticalSpace,
              buildDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildRowDetails(
                    iconImage: IconsAssets.tripTime,
                    label: 'تحديد وقت الرحلة',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        showPicker(
                          is24HrFormat: false,
                          iosStylePicker: true,
                          dialogInsetPadding: const EdgeInsets.all(0),
                          context: context,
                          value: Time(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute,
                          ),
                          onChange: (value) {
                            String hour = value.hour.toString();
                            String minute = value.minute.toString();
                            if (hour.length == 1) {
                              hour = "0$hour";
                            }
                            if (minute.length == 1) {
                              minute = "0$minute";
                            }
                            controller.time = "$hour:$minute";
                          },
                        ),
                      );
                    },
                    child: Obx(
                      () => CustomText(
                          text: convertFrom24To12HourTypes(
                            currentTime: controller.time,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: 15.sp,
                              )),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Row(
                children: [
                  CustomText(
                      text: "${el.tr(AppStrings.tripFor)} :",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15.sp)),
                ],
              ),
              10.verticalSpace,
              Obx(
                () => Row(
                  children: [
                    InkWell(
                      onTap: () => controller.changetripFor('for_men'),
                      child: Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                            color: ColorManger.white,
                            boxShadow: getBoxShadow(),
                            border: controller.tripFor == 'for_men'
                                ? Border.all(color: ColorManger.primary)
                                : null,
                            borderRadius: BorderRadius.circular(AppSize.s7)),
                        child: CustomText(
                            text: el.tr(AppStrings.formen),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 15.sp)),
                      ),
                    ),
                    10.horizontalSpace,
                    InkWell(
                      onTap: () => controller.changetripFor('for_women'),
                      child: Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                            color: ColorManger.white,
                            boxShadow: getBoxShadow(),
                            border: controller.tripFor == 'for_women'
                                ? Border.all(color: ColorManger.primary)
                                : null,
                            borderRadius: BorderRadius.circular(AppSize.s7)),
                        child: CustomText(
                            text: el.tr(AppStrings.forWomen),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 15.sp)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: AppButton(
              text: el.tr(AppStrings.done),
              textStyle:
                  Get.textTheme.bodyLarge!.copyWith(color: ColorManger.white),
              onTap: () {
                controller.customerOrders();
                Get.back();
              },
              color: ColorManger.blackText,
              width: 354.w,
              height: 60.h,
              borderRadios: 50.r),
        ),
      ),
    );
  }

  Widget locationTextFeildShimmer() {
    return const Padding(
      padding: EdgeInsetsDirectional.only(end: 16),
      child: CustomShimmer(height: 50, width: double.infinity),
    );
  }

  Divider buildDivider() {
    return Divider(
      indent: 6.w,
      endIndent: 7.w,
      color: ColorManger.iconLightGreyColor,
    );
  }

  Widget buildRowDetails({required String iconImage, required String label}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            children: [
              SvgPicture.asset(iconImage),
              12.horizontalSpace,
              CustomText(text: label),
            ],
          ),
        ),
      ],
    );
  }
}
