import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/features/available_trips/presentation/view/private_trip.dart';
import 'package:take_me_with_you/imports.dart';
import 'package:take_me_with_you/core/utils/function.dart' as type;

class AvailableTripsView extends GetView<AvailableTripsController> {
  AvailableTripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(AppRoutes.serviceRoute);
        return Future.value(false);
      },
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: ColorManger.lightWhite,
        drawer: const ServiceDrawer(drawerType: type.DrawerType.customer),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              12.horizontalSpace,
              AppBackButton(
                onTap: () {
                  Get.offAllNamed(AppRoutes.serviceRoute);
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    el.tr(AppStrings.tripsFilter),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              6.horizontalSpace,
              GestureDetector(
                onTap: () {
                  showDropdown(context);
                },
                child: const Icon(Icons.more_vert, color: Colors.black),
              ),
              4.horizontalSpace,
              AppBackButton(
                onTap: () {
                  Get.lazyPut(() => AvailableTripsController());
                  Get.to(() => const FilterTripView())!.then((value) {
                    if (value == 'refresh') {
                      controller.numSeats.text = "";
                      controller.toController.text = "";
                      controller.fromController.text = "";
                      controller.tripFor = "";
                      controller.timeDate = el.tr(AppStrings.now).obs;
                      controller.onInit();
                    }
                  });
                },
                iconImage: IconsAssets.drawer,
                iconHeight: 17.h,
              ),
              10.horizontalSpace,
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            right: 22.w,
            top: 20.h,
            left: 22.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("الرحلات المتوفرة : ", style: Get.textTheme.titleMedium),
                ],
              ),
              10.verticalSpace,
              Obx(
                () => !controller.loading &&
                        controller.failure.value.message.isNotEmpty
                    ? ContentErrorWidget(
                        description: controller.failure.value.message,
                        errorCode: controller.failure.value.code,
                        buttonTitle: AppStrings.tryAgain,
                        onPress: () async {
                          controller.failure.value.message = "";
                          return await controller.customerOrders();
                        })
                    : controller.loading
                        ? const CupertinoActivityIndicator()
                        : controller.orderModel.userOrders!.isEmpty
                            ? const Center(
                                child: Text('لا يوجد بيانات',
                                    style: TextStyle(color: Colors.black)),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.orderModel.userOrders!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return controller.loading
                                      ? Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0.w, 6.h, 22.w, 6.h),
                                          child: ShimmerWidget.rectangular(
                                              width: 0.75.sw, height: 0.3.sh),
                                        )
                                      : TripCard(
                                          orderData: controller
                                              .orderModel.userOrders![index],
                                        );
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
