import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/empty_screen.dart';
import 'package:take_me_with_you/core/widgets/loading/loading_list_big_item.dart';
import 'package:take_me_with_you/features/my_old_trips/presentation/getx/my_old_trips_controller.dart';

import 'my_old_trips_widget.dart';

class MyOldTripsList extends GetView<MyOldTripsController> {
  const MyOldTripsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading
          ? const LoadingListBigItem()
          : controller.trips.isEmpty
              ? EmptyPage(emptyMessage: AppStrings.emptyInProgressTrips)
              : Column(
                  children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            right: 8.w, left: 21.5.w, bottom: 30.h),
                        itemBuilder: (context, index) =>
                            MyOldTripsWidget(model: controller.trips[index]),
                        separatorBuilder: (context, index) => 24.verticalSpace,
                        itemCount: controller.trips.length),
                    if (controller.loadingPagination)
                      const Padding(
                        padding: EdgeInsets.all(AppPadding.p14),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                  ],
                ),
    );
  }
}
