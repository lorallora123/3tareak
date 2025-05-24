import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/features/my_old_trips/presentation/getx/my_old_trips_controller.dart';
import 'package:take_me_with_you/features/my_old_trips/presentation/widget/my_old_trips_app_bar.dart';
import 'package:take_me_with_you/features/my_old_trips/presentation/widget/my_old_trips_list.dart';

class MyOldTripsView extends GetView<MyOldTripsController> {
  const MyOldTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyOldTripsAppBar(),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        padding: EdgeInsets.only(right: 19.5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [36.verticalSpace, const MyOldTripsList()],
        ),
      ),
    );
  }
}
