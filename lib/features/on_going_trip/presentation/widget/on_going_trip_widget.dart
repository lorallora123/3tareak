import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/extensions.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/custom_swipe_buttons/start_trip_swipe_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/core/widgets/from_to_widget.dart';
import 'package:take_me_with_you/features/cancel_trip/presentation/getx/call_cancel_trip_bottom_sheet.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/getx/on_going_trip_controller.dart';

import 'finish_trip_page.dart';

class OnGoingTripWidget extends GetView<OnGoingTripController> {
  const OnGoingTripWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Column(
        children: [
          controller.thereAreOrder ? 42.verticalSpace : 55.verticalSpace,
          FromToWidget(
              from: controller.trip.fromPlace!, to: controller.trip.toPlace!),
          31.verticalSpace,
          Divider(
            color: ColorManager.borderGreyColor,
            indent: 14.w,
          ),
          26.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                IconsAssets.seats,
                width: 14.w,
                height: 21.h,
              ),
              20.horizontalSpace,
              CustomText(
                  text: el.tr(AppStrings.numberOfSeatsAvailable),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              const Spacer(),
              CustomText(
                  text: controller.trip.seatNumber.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            ],
          ),
          24.verticalSpace,
          Divider(
            color: ColorManager.borderGreyColor,
            indent: 14.w,
          ),
          24.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                IconsAssets.notes,
                width: 14.w,
                height: 21.h,
              ),
              20.horizontalSpace,
              CustomText(
                  text: el.tr(AppStrings.notes),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              const Spacer(),
              SizedBox(
                width: 0.5.sw,
                child: CustomText(
                    text: controller.trip.notes!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15.sp)),
              ),
            ],
          ),
          24.verticalSpace,
          Divider(
            color: ColorManager.borderGreyColor,
            indent: 14.w,
          ),
          24.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                IconsAssets.tripTime,
                width: 14.w,
                height: 21.h,
              ),
              20.horizontalSpace,
              CustomText(
                  text: el.tr(AppStrings.tripTime),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              const Spacer(),
              CustomText(
                  text: convertFrom24To12HourTypes(
                          currentTime: controller.trip.startedAt!.toString())
                      .orEmpty(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            ],
          ),
          24.verticalSpace,
          Divider(
            color: ColorManager.borderGreyColor,
            indent: 14.w,
          ),
          24.verticalSpace,
          if (controller.trip.vehicle != null) ...[
            Row(
              children: [
                SvgPicture.asset(
                  IconsAssets.vehicleType,
                  width: 14.w,
                  height: 21.h,
                ),
                20.horizontalSpace,
                CustomText(
                    text: el.tr(AppStrings.vehicle),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15.sp)),
                const Spacer(),
                CustomText(
                    text: controller.trip.vehicle!.model ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15.sp)),
              ],
            ),
            24.verticalSpace,
            Divider(
              color: ColorManager.borderGreyColor,
              indent: 14.w,
            )
          ],
          if (!controller.thereAreOrder) ...[
            const Spacer(),
            GestureDetector(
              onTap: () => callCancelTripBottomSheet(controller.trip.id ?? 0),
              child: CustomText(
                  text: el.tr(AppStrings.cancelTrip),
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 15.sp)),
            )
          ],
          34.verticalSpace,
          if (controller.trip.customers!.isNotEmpty) ...[
            if (controller.trip.status == "pending")
              StartTripSwipeButton(
                onAnimationEnd: controller.captainStartTrip,
              )
            else
              AppButton(
                text: el.tr(AppStrings.finishTrip),
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: ColorManager.white),
                onTap: () => Get.to(() => const FinishTripPage()),
                color: ColorManager.primary,
                borderRadios: AppSize.s30,
                width: 351.w,
                height: 54.h,
              ),
          ]
        ],
      ),
    );
  }
}
