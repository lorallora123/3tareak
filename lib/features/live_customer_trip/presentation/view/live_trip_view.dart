import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/design_constants.dart';
import 'package:take_me_with_you/core/utils/extensions.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/app_back_button.dart';
import 'package:take_me_with_you/core/widgets/app_image.dart';
import 'package:take_me_with_you/core/widgets/bottom_sheet/cancel_order.dart';
import 'package:take_me_with_you/core/widgets/custom_swipe_buttons/call_swipe_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/core/widgets/errors/content_error_widget.dart';
import 'package:take_me_with_you/core/widgets/from_to_widget.dart';
import 'package:take_me_with_you/core/widgets/shimmer/shimmer_card.dart';
import 'package:take_me_with_you/features/live_customer_trip/presentation/getx/live_trip_controller.dart';

class LiveTripView extends GetView<LiveTripController> {
  const LiveTripView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: ColorManager.lightWhite,
      body: Stack(
        children: [
          controller.status == "join"
              ? Scrollbar(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 1.sw,
                        height: 1.sh,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            boxShadow: [veryLowElevation]),
                        padding: EdgeInsets.fromLTRB(22.w, 30.h, 22.w, 0),
                        child: Obx(() => !controller.loading &&
                                controller.failure.value.message.isNotEmpty
                            ? ContentErrorWidget(
                                description: controller.failure.value.message,
                                errorCode: controller.failure.value.code,
                                buttonTitle: AppStrings.tryAgain,
                                onPress: () async {
                                  controller.failure.value.message = "";
                                  return await controller.getOnGoingOrder();
                                })
                            : !controller.loading
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.bottomSheet(
                                                const CancelOrder(),
                                                isDismissible: false,
                                                backgroundColor:
                                                    ColorManager.white,
                                              );
                                            },
                                            child: Text("إلغاء الطلب",
                                                style: Get
                                                    .textTheme.displayLarge!
                                                    .copyWith(fontSize: 16.sp)),
                                          ),
                                        ],
                                      ),
                                      20.verticalSpace,
                                      Text("تفاصيل الطلب",
                                          style: Get.textTheme.titleMedium),
                                      20.verticalSpace,
                                      FromToWidget(
                                        from: controller
                                            .orderUserModel.order!.fromPlace
                                            .orEmpty(),
                                        to: controller.orderUserModel.toPlace
                                            .orEmpty(),
                                        space: 10.h,
                                      ),
                                      20.verticalSpace,
                                      buildDivider(),
                                      buildRowDetails(
                                        iconImage: IconsAssets.seats,
                                        label: el.tr(
                                            AppStrings.numberOfSeatsReserved),
                                        detail:
                                            "${controller.orderUserModel.seatNumber.orZero()}/${controller.orderUserModel.order!.vehicle!.seatNumber.orZero()}",
                                      ),
                                      buildRowDetails(
                                        iconImage: IconsAssets.pin,
                                        label: 'مسار الرحلة',
                                        detail: controller
                                                .orderUserModel.order!.notes ??
                                            "لايوجد",
                                      ),
                                      buildRowDetails(
                                        iconImage: IconsAssets.tripTime,
                                        label: 'وقت الرحلة',
                                        detail: convertFrom24To12HourTypes(
                                                currentTime: controller
                                                    .orderUserModel
                                                    .order!
                                                    .startedAt
                                                    .toString())
                                            .orEmpty(),
                                      ),
                                      buildRowDetails(
                                        iconImage: IconsAssets.vehicleType,
                                        label: 'المركبة',
                                        detail:
                                            "${controller.orderUserModel.order!.vehicle!.model.orEmpty()} / ${controller.orderUserModel.order!.vehicle!.color.orEmpty()} / ${controller.orderUserModel.order!.vehicle!.type}",
                                      ),
                                    ],
                                  )
                                : const ShimmerCard()),
                      ),
                    ],
                  ),
                )
              : Scrollbar(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 1.sw,
                        height: 1.sh,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            boxShadow: [veryLowElevation]),
                        padding: EdgeInsets.fromLTRB(22.w, 30.h, 22.w, 0),
                        child: Obx(() => !controller.loading &&
                                controller.failure.value.message.isNotEmpty
                            ? ContentErrorWidget(
                                description: controller.failure.value.message,
                                errorCode: controller.failure.value.code,
                                buttonTitle: AppStrings.tryAgain,
                                onPress: () async {
                                  controller.failure.value.message = "";
                                  return await controller.getOnGoingOrder();
                                })
                            : !controller.loading &&
                                    controller.orderUserModel.order != null
                                ? Stack(
                                    children: [
                                      Positioned.fill(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              20.horizontalSpace,
                                              buildCaptainInfo(),
                                              8.horizontalSpace,
                                              buildCarInfo(),
                                              20.verticalSpace,
                                              CallSwipeButton(
                                                isCaptain: false,
                                                phone: controller
                                                        .orderUserModel
                                                        .order
                                                        ?.captain
                                                        ?.user
                                                        ?.phoneNumber ??
                                                    "",
                                              ),
                                              30.verticalSpace,
                                              buildDivider(),
                                              12.verticalSpace,
                                              Text("تفاصيل الطلب",
                                                  style: Get
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                          fontSize: 18.sp)),
                                              20.verticalSpace,
                                              FromToWidget(
                                                from: controller.orderUserModel
                                                    .order!.fromPlace
                                                    .orEmpty(),
                                                to: controller.orderUserModel
                                                    .order!.toPlace
                                                    .orEmpty(),
                                                space: 10.h,
                                              ),
                                              20.verticalSpace,
                                              buildDivider(),
                                              buildRowDetails(
                                                iconImage: IconsAssets.seats,
                                                label: 'عدد المقاعد المحجوزة',
                                                detail:
                                                    "${controller.orderUserModel.seatNumber.orZero()}/${controller.orderUserModel.order?.vehicle?.seatNumber.orZero()}",
                                              ),
                                              buildRowDetails(
                                                iconImage: IconsAssets.pin,
                                                label: 'مسار الرحلة',
                                                detail: controller
                                                        .orderUserModel
                                                        .order
                                                        ?.notes ??
                                                    "لا يوجد",
                                              ),
                                              buildRowDetails(
                                                iconImage: IconsAssets.pin,
                                                label: 'وقت الرحلة',
                                                detail: convertFrom24To12HourTypes(
                                                        currentTime: controller
                                                            .orderUserModel
                                                            .order!
                                                            .startedAt
                                                            .toString())
                                                    .orEmpty(),
                                              ),
                                              buildRowDetails(
                                                iconImage: IconsAssets.pin,
                                                label: 'كلفة الرحلة',
                                                detail:
                                                    "${controller.orderUserModel.order!.total! * controller.orderUserModel.seatNumber!}",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: Get.height,
                                    width: Get.width,
                                    child: const Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  )),
                      ),
                    ],
                  ),
                ),
          const Positioned(
            right: 10,
            top: 10,
            child: AppBackButton(),
          ),
        ],
      ),
    );
  }

  Column buildCarInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(ImageAssets.car),
        CustomText(
          text:
              "${controller.orderUserModel.order?.vehicle!.model.orEmpty()} / ${controller.orderUserModel.order?.vehicle!.color.orEmpty()} / ${controller.orderUserModel.order?.vehicle!.type?.type ?? ""}",
        ),
        CustomText(
          text: (controller.orderUserModel.order?.vehicle!.boardNumber ?? 0)
              .toString(),
          style: Get.textTheme.displayMedium,
        ),
      ],
    );
  }

  Row buildCaptainInfo() {
    return Row(
      children: [
        if (controller.orderUserModel.order?.captain != null)
          AppImage(
            width: 60.w,
            height: 60.w,
            imageUrl:
                controller.orderUserModel.order?.captain?.user?.image ?? "",
            boxFit: BoxFit.cover,
          ),
        15.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                text:
                    controller.orderUserModel.order?.captain?.user?.fullName ??
                        ""),
          ],
        )
      ],
    );
  }

  Divider buildDivider() {
    return Divider(
      indent: 6.w,
      endIndent: 7.w,
      color: ColorManager.iconLightGreyColor,
    );
  }

  Widget buildRowDetails(
      {required String iconImage,
      required String label,
      required String detail}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            children: [
              SvgPicture.asset(iconImage),
              12.horizontalSpace,
              CustomText(text: label),
              const Spacer(),
              SizedBox(width: 0.35.sw, child: CustomText(text: detail)),
            ],
          ),
        ),
        buildDivider(),
      ],
    );
  }
}
