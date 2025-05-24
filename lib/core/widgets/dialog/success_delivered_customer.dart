import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/models/finished_trip_response.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

class SuccessDeliveredCustomer extends StatelessWidget {
  final FinishedTripDataResponse model;

  const SuccessDeliveredCustomer({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            width: 313.w,
            height: 313.h,
            padding: EdgeInsets.only(
                top: 64.h, bottom: 58.h, left: 29.w, right: 29.w),
            decoration: const BoxDecoration(
                color: ColorManger.white, shape: BoxShape.circle),
            child: Column(
              children: [
                CustomText(
                    text: el.tr(AppStrings.customerDeliveredSuccessfully),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 20.sp)),
                27.verticalSpace,
                Container(
                  width: 255.w,
                  height: 33.h,
                  padding: EdgeInsets.only(right: 5.w, left: 10.w),
                  decoration: BoxDecoration(
                      color: ColorManger.greyColor,
                      borderRadius: BorderRadius.circular(AppSize.s4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text:
                              "${el.tr(AppStrings.distanceTraveledForTheTrip)} :",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp)),
                      CustomText(
                          text: "${model.distance} ${el.tr(AppStrings.km)}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp)),
                    ],
                  ),
                ),
                28.verticalSpace,
                CustomText(
                    text:
                        "${el.tr(AppStrings.amountReceivedFromTheCustomer)} :",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15.sp)),
                13.verticalSpace,
                CustomText(
                  text:
                      "${double.parse(model.price!) * int.parse(model.reservedSeats!)} ${el.tr(AppStrings.sp)}",
                  style: Theme.of(context).textTheme.displayLarge!,
                )
              ],
            ),
          ),
          26.verticalSpace,
          AppButton(
            text: el.tr(AppStrings.confirm),
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorManger.white),
            onTap: () => Get.back(),
            color: ColorManger.primary,
            borderRadios: AppSize.s30,
            width: 253.w,
            height: 53.h,
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
