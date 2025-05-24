import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/empty_screen.dart';

import '../getx/my_old_order_controller.dart';
import 'my_old_order_widget.dart';

class MyOldOrdersListItem extends GetView<MyOldOrdersController> {
  const MyOldOrdersListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.loading) {
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if (!controller.loading && controller.customerTripModel.isEmpty) {
          return EmptyPage(
            emptyMessage: AppStrings.emptyInProgressOrder,
          );
        }
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(right: 8.w, left: 21.5.w),
          itemBuilder: (context, index) => MyOldOrdersWidget(
              customerTrip: controller.customerTripModel[index]),
          separatorBuilder: (context, index) => 24.verticalSpace,
          itemCount: controller.customerTripModel.length,
        );
      },
    );
  }
}
