import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class DetailsView extends GetView<TripDetailsController> {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        controller.onBack();
        return Future.value(false);
      },
      child: Obx(
        () => Scaffold(
          appBar: controller.index < 4
              ? AppBar(
                  automaticallyImplyLeading: false,
                  title: CustomText(
                    text: controller.index == 1
                        ? "تفاصيل الرحلة"
                        : controller.index == 2
                            ? "تفاصيل طلبك"
                            : controller.index == 3
                                ? "الرجاء اختيار موقعك"
                                : "",
                    style: Get.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: AppBackButton(
                      onTap: () {
                        controller.onBack();
                      },
                    ),
                  ),
                )
              : null,
          body: controller.index == 1
              ? TripDetailsView(orderData: controller.orderData)
              : controller.index == 2
                  ? const YourTripDetailsView()
                  : controller.index == 3
                      ? const SelectAddressMapView(
                          isOrigin: true, hideButton: true)
                      : const SendRequestPage(),
          floatingActionButton: controller.index < 4
              ? Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: AppButton(
                      text: el.tr(AppStrings.next),
                      textStyle: Get.textTheme.bodyLarge!
                          .copyWith(color: ColorManger.white),
                      onTap: () {
                        if (controller.index == 2 && controller.numSeats == 0) {
                          AppMessage.showToast('الرجاء اختيار عدد المقاعد');
                        } else if (controller.index == 3) {
                          if (controller.isClientLocationNotSelected()) {
                            AppMessage.showToast('الرجاء اختيار موقعك');
                          } else {
                            controller.setClientLatLng();
                            controller.onNext();
                          }
                        } else {
                          controller.onNext();
                        }
                      },
                      color: ColorManger.blackText,
                      width: 354.w,
                      height: 60.h,
                      borderRadios: 50.r),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
