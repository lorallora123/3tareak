import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class SendRequestPage extends GetView<TripDetailsController> {
  const SendRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ColorManager.white,
          width: 1.sw,
          height: 1.sh,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            IconsAssets.finishTripBackground,
            fit: BoxFit.cover,
            width: 1.sw,
            height: 708.h,
          ),
        ),
        SizedBox(
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              100.verticalSpace,
              Row(
                children: [
                  50.horizontalSpace,
                  CustomText(
                    text: "عدد المقاعد",
                    textAlign: TextAlign.center,
                    style:
                        Get.textTheme.displayMedium!.copyWith(fontSize: 16.sp),
                  ),
                  12.horizontalSpace,
                  CustomText(
                    text: controller.numSeats.toString(),
                    style:
                        Get.textTheme.displayLarge!.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              15.verticalSpace,
              Row(
                children: [
                  50.horizontalSpace,
                  CustomText(
                    text: "سعر المقعد",
                    textAlign: TextAlign.center,
                    style:
                        Get.textTheme.displayMedium!.copyWith(fontSize: 16.sp),
                  ),
                  12.horizontalSpace,
                  CustomText(
                    text: controller.orderData.total!.toString(),
                    style:
                        Get.textTheme.displayLarge!.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              15.verticalSpace,
              Row(
                children: [
                  50.horizontalSpace,
                  CustomText(
                    text: "المبلغ التقديري للرحلة",
                    textAlign: TextAlign.center,
                    style:
                        Get.textTheme.displayMedium!.copyWith(fontSize: 16.sp),
                  ),
                  12.horizontalSpace,
                  CustomText(
                    text:
                        " ${controller.orderData.total! * controller.numSeats}  ل.س  ",
                    style:
                        Get.textTheme.displayLarge!.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              15.verticalSpace,
              Icon(
                Icons.keyboard_arrow_up,
                color: ColorManager.primary,
                size: 30.w,
              ),
              SvgPicture.asset(
                IconsAssets.finishTripArrow,
                fit: BoxFit.fitHeight,
                width: 5.w,
                height: 455.h,
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 76.w,
            leading: Row(
              children: [
                22.horizontalSpace,
                AppBackButton(
                  onTap: () {
                    controller.onBack();
                  },
                )
              ],
            ),
          ),
          body: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Stack(
              children: [
                Column(
                  children: [
                    const Spacer(),
                    Center(
                      child: CustomText(
                          text: el.tr(AppStrings.swipeUpToSendTrip),
                          style: Theme.of(context).textTheme.titleLarge!),
                    ),
                    37.verticalSpace
                  ],
                ),
                Positioned(
                  right: 140.16.w,
                  top: 530.h,
                  child: VerticalSwipeButton(onAnimationEnd: () async {
                    Get.dialog(AlertDialog(
                      content: PayTypeDialog(),
                    ));
                  }),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
