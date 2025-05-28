import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/widgets/loading/loading_list_big_item.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/getx/on_going_trip_controller.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/widget/customer_trip_info.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/widget/on_going_trip_app_bar.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/widget/on_going_trip_widget.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/widget/trip_tap_bar.dart';

class OnGoingTripView extends GetView<OnGoingTripController> {
  const OnGoingTripView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Get.offNamed(AppRoutes.myOnGoingTripsRoute);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: OnGoingTripAppBar(onPress: () {
          Get.offNamed(AppRoutes.myOnGoingTripsRoute);
        }),
        body: Obx(
          () => controller.loading
              ? const LoadingListBigItem()
              : Column(
                  children: [
                    26.verticalSpace,
                    if (controller.thereAreOrder) ...[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DefaultTabController(
                            length: controller.trip.customers!.length + 1,
                            child: Row(
                              children: [
                                TabBar(
                                  controller: controller.tabController,
                                  isScrollable: true,
                                  padding: EdgeInsets.only(right: 31.w),
                                  indicatorColor: Colors.transparent,
                                  labelPadding: EdgeInsets.zero,
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  tabs: List.generate(
                                    controller.trip.customers!.length + 1,
                                    (index) =>
                                        Tab(child: TripTabBar(index: index)),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            const SingleChildScrollView(
                                child: OnGoingTripWidget()),
                            for (int i = 0;
                                i < controller.trip.customers!.length;
                                i++)
                              CustomerTripInfo(
                                index: i,
                              )
                          ],
                        ),
                      ),
                      10.verticalSpace,
                    ] else
                      const Expanded(child: OnGoingTripWidget()),
                  ],
                ),
        ),
      ),
    );
  }
}
