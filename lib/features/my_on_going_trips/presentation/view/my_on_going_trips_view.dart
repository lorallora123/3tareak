import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/empty_screen.dart';
import 'package:take_me_with_you/core/widgets/loading/loading_list_big_item.dart';
import 'package:take_me_with_you/features/my_on_going_trips/presentation/getx/my_on_going_trips_controller.dart';
import 'package:take_me_with_you/features/my_on_going_trips/presentation/widget/my_on_going_trips_app_bar.dart';
import 'package:take_me_with_you/features/my_on_going_trips/presentation/widget/my_on_going_trips_item.dart';

class MyOnGoingTripsView extends GetView<MyOnGoingTripsController> {
  const MyOnGoingTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: const MyOnGoingTripsAppBar(),
        // drawer: const ServiceDrawer(drawerType: DrawerType.captain),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.5.w),
            child: Obx(
              () => controller.loading
                  ? const LoadingListBigItem()
                  : controller.orders == null || controller.orders!.id == 0
                      ? EmptyPage(emptyMessage: AppStrings.emptyInProgressTrips)
                      : Column(
                          children: [
                            40.verticalSpace,
                            if (controller.orders != null)
                              MyOnGoingTripsItem(
                                  model: controller.orders!,
                                  availableSeats: controller
                                      .captainTripsModel!.availableSeats!,
                                  onTap: () {
                                    Get.offNamed(AppRoutes.onGoingTripsRoute,
                                        arguments: {
                                          'orderId': controller.orders!.id,
                                        });
                                  }),
                            50.verticalSpace
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
