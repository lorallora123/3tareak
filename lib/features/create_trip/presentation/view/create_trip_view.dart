import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class CreateTripView extends GetView<CreateTripController> {
  CreateTripView({this.isPrivate = false, super.key});
  final bool isPrivate;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateTripAppBar(isPrivate: isPrivate),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.5.w),
          child: Column(
            children: [
              25.verticalSpace,
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
                              child: GetBuilder<CreateTripController>(
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
                              child: GetBuilder<CreateTripController>(
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
              57.verticalSpace,
              const Divider(color: ColorManger.borderGreyColor),
              19.verticalSpace,
              if (!isPrivate) ...[
                Row(
                  children: [
                    SvgPicture.asset(
                      IconsAssets.seats,
                      width: 14.w,
                      height: 21.h,
                    ),
                    9.horizontalSpace,
                    CustomText(
                        text: "${el.tr(AppStrings.numberOfSeatsAvailable)} :",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15.sp))
                  ],
                ),
                29.verticalSpace,
                Obx(
                  () => SizedBox(
                    height: 49.69117736816406.h,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Obx(
                            () => SeatsNumberContainer(
                              onTap: () => controller.seatsNumber = index + 1,
                              color: controller.seatsNumber == index + 1
                                  ? ColorManger.primary
                                  : ColorManger.textGrueColor,
                              index: index,
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            34.46.horizontalSpace,
                        itemCount: isPrivate
                            ? 5
                            : Get.find<VehicleSelectionController>()
                                    .selectedVehicle
                                    .value
                                    .seatNumber ??
                                0),
                  ),
                ),
                25.verticalSpace,
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
                20.verticalSpace,
                const Divider(color: ColorManger.borderGreyColor),
                AppTextFiled(
                  isSvg: true,
                  controller: controller.noteController,
                  hint: "ميدان-كفرسوسة-المزة",
                  svgPrefixIcon: IconsAssets.notes,
                  label: "${el.tr(AppStrings.notes)} :",
                  suffixText: "${el.tr(AppStrings.notes)} :",
                  textAlign: TextAlign.end,
                  validator: valid,
                ),
                25.verticalSpace,
              ] else ...[
                AppTextFiled(
                  label: el.tr('عدد المقاعد المطلوبة'),
                  prefixIcon: Icons.person,
                  action: TextInputAction.done,
                  controller: controller.wantedSeatsController,
                  keyboardType: TextInputType.number,
                ),
                30.verticalSpace,
              ],
              Row(
                children: [
                  SvgPicture.asset(
                    IconsAssets.tripTime,
                    width: 17.w,
                    height: 17.h,
                  ),
                  15.horizontalSpace,
                  CustomText(
                      text: "${el.tr(AppStrings.tripTime)} :",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15.sp)),
                  const Spacer(),
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
              )
            ],
          ),
        ),
      ),
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? const SizedBox()
          : Obx(
              () => controller.loading
                  ? const CircularProgressIndicator()
                  : AppButton(
                      text: el.tr(AppStrings.start),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ColorManger.white),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.createOrder(isPrivate: isPrivate);
                        }
                      },
                      color: ColorManger.blackText,
                      borderRadios: AppSize.s30,
                      width: 346.w,
                      height: 53.h,
                    ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget locationTextFeildShimmer() {
    return const Padding(
      padding: EdgeInsetsDirectional.only(end: 16),
      child: CustomShimmer(height: 50, width: double.infinity),
    );
  }
}
