import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_image.dart';
import 'package:take_me_with_you/core/widgets/custom_swipe_buttons/call_swipe_button.dart';
import 'package:take_me_with_you/core/widgets/custom_swipe_buttons/swipe_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/core/widgets/delivered_button.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/getx/on_going_trip_controller.dart';

class CustomerTripInfo extends GetView<OnGoingTripController> {
  final int index;

  const CustomerTripInfo({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: Column(
        children: [
          13.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                  text: "${el.tr(AppStrings.orderStatus)} :",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              Container(
                width: 80.w,
                height: 80.h,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s100),
                  child: AppImage(
                    imageUrl:
                        controller.trip.customers![index].customer?.image ?? "",
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
              CustomText(
                  text: controller.getCustomerStatus(
                      controller.trip.customers![index].status!),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 15.sp,
                      color: controller.trip.customers![index].status == 'join'
                          ? ColorManager.blueColor
                          : ColorManager.primary)),
            ],
          ),
          25.verticalSpace,
          const Divider(color: ColorManager.borderGreyColor),
          25.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "${el.tr(AppStrings.customerName)} :",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              CustomText(
                  text: controller.trip.customers![index].customer!.fullName ??
                      '',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            ],
          ),
          25.verticalSpace,
          const Divider(color: ColorManager.borderGreyColor),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "الموقع :",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              TextButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.tripMapView,
                    arguments: {
                      'clientLocation': LatLng(
                        controller.trip.customers![index].lat!,
                        controller.trip.customers![index].lng!,
                      ),
                    },
                  );
                },
                child: CustomText(
                    text: 'الرؤية على الخريطة',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 15.sp,
                          color: ColorManager.primary,
                        )),
              ),
            ],
          ),
          10.verticalSpace,
          const Divider(color: ColorManager.borderGreyColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "${el.tr(AppStrings.numberOfSeatsReserved)} :",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              CustomText(
                  text: controller.trip.customers![index].seatNumber.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            ],
          ),
          25.verticalSpace,
          const Divider(color: ColorManager.borderGreyColor),
          25.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "${el.tr(AppStrings.customerPhone)} :",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              CallSwipeButton(
                  isCaptain: true,
                  phone:
                      controller.trip.customers![index].customer!.phoneNumber),
            ],
          ),
          25.verticalSpace,
          const Divider(color: ColorManager.borderGreyColor),
          30.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "الكلفة الكلية",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              CustomText(
                  text:
                      (double.parse(controller.trip.customers![index].price!) *
                              controller.trip.customers![index].seatNumber!)
                          .toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            ],
          ),
          25.verticalSpace,
          const Divider(color: ColorManager.borderGreyColor),
          controller.trip.customers![index].status == "end"
              ? const DeliveredButton()
              : SwipeButton(
                  onAnimationEnd: () =>
                      controller.trip.customers![index].status == "join"
                          ? controller.customerInOrder(index)
                          : controller.customerOutOrder(index),
                  index: index,
                  text: controller.trip.customers![index].status == "join"
                      ? el.tr(AppStrings.swipeToConfirmCustomerBoarding)
                      : el.tr(AppStrings.swipeToConfirmDelivery),
                  isPrimary: controller.trip.customers![index].status == "join"
                      ? false
                      : true),
          22.verticalSpace,
        ],
      ),
    );
  }
}
