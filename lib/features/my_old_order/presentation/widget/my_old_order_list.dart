// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:take_me_with_you/presentation/my_old_order/getx/my_old_order_controller.dart';
// import 'package:take_me_with_you/presentation/widget/shimmer/shimmer_widget.dart';
//
// import 'my_old_order_widget.dart';
//
// class MyOldOrdersList extends GetView<MyOldOrdersController> {
//   const MyOldOrdersList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//         // ListView.separated(
//         //   physics: const NeverScrollableScrollPhysics(),
//         //   shrinkWrap: true,
//         //   padding: EdgeInsets.only(bottom: 36.h),
//         //   itemBuilder: (context, index) => const MyOldOrdersListItem(),
//         //   separatorBuilder: (context, index) => 38.verticalSpace,
//         //   itemCount: 2)
//
//         Obx(
//       () => ListView.separated(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           padding: EdgeInsets.only(right: 8.w, left: 21.5.w),
//           itemBuilder: (context, index) => controller.loading
//               ? ShimmerWidget.rectangular(height: 200.h)
//               : MyOldOrdersWidget(customerTrip: controller.customerTripModel[index]),
//           separatorBuilder: (context, index) => 24.verticalSpace,
//           itemCount: controller.loading ? 3 : controller.customerTripModel.length),
//     );
//   }
// }
