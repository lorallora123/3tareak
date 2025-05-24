import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/my_old_trips/presentation/getx/my_old_trips_controller.dart';

class MyOldTripsListItem extends GetView<MyOldTripsController> {
  const MyOldTripsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: "الاثنين 12 يوليو 2023",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 15.sp)),
        29.verticalSpace,
        // ListView.separated(
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     padding: EdgeInsets.only(right: 8.w, left: 21.5.w),
        //     itemBuilder: (context, index) =>
        //         MyOldTripsWidget(model: controller.orders[index]),
        //     separatorBuilder: (context, index) => 24.verticalSpace,
        //     itemCount: controller.orders.length)
      ],
    );
  }
}
