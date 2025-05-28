// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:take_me_with_you/app/extensions.dart';
// import 'package:take_me_with_you/app/function.dart';
// import 'package:take_me_with_you/resources/assets_manger.dart';
//
// import '../../../resources/color_manger.dart';
// import '../../../resources/design_constants.dart';
// import '../../../resources/string_manger.dart';
// import '../../widget/bottom_sheet/cancel_order.dart';
// import '../../widget/custom_text.dart';
// import '../../widget/errors/content_error_widget.dart';
// import '../../widget/from_to_widget.dart';
// import '../../widget/shimmer/shimmer_card.dart';
// import '../getx/live_trip_controller.dart';
//
// class OnGoingTripsBottomSheet extends GetView<LiveTripController> {
//   const OnGoingTripsBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildDraggableScrollableSheet();
//   }
//
//   Widget _buildDraggableScrollableSheet() {
//     return DraggableScrollableSheet(
//       initialChildSize: 0.1,
//       minChildSize: 0.1,
//       maxChildSize: 0.7,
//       builder: (BuildContext context, ScrollController scrollController) {
//         return ListView(
//           controller: scrollController,
//           children: [
//             Scrollbar(
//               controller: scrollController,
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned(
//                     top: -40,
//                     child: Container(
//                       height: 100.h,
//                       width: 100.h,
//                       decoration: BoxDecoration(
//                           color: ColorManger.white,
//                           borderRadius: BorderRadius.circular(100.r),
//                           boxShadow: [veryLowElevation]),
//                       padding: EdgeInsets.fromLTRB(40.w, 1.h, 40.w, 50.h),
//                       child: SvgPicture.asset(
//                         scrollController.keepScrollOffset ? IconsAssets.upArrow : IconsAssets.downArrow,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 1.sw,
//                     height: 0.7.sh,
//                     decoration: BoxDecoration(
//                         color: ColorManger.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(15.r),
//                           topRight: Radius.circular(15.r),
//                         ),
//                         boxShadow: [veryLowElevation]),
//                     padding: EdgeInsets.fromLTRB(22.w, 30.h, 22.w, 0),
//                     child: Obx(() => !controller.loading && controller.failure.value.message.isNotEmpty
//                         ? ContentErrorWidget(
//                             description: controller.failure.value.message,
//                             errorCode: controller.failure.value.code,
//                             buttonTitle: AppStrings.tryAgain,
//                             onPress: () async {
//                               controller.failure.value.message = "";
//                               return await controller.getOnGoingOrder();
//                             })
//                         : !controller.loading
//                             ? Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           Get.bottomSheet(
//                                             const CancelOrder(),
//                                             isDismissible: false,
//                                             backgroundColor: ColorManger.white,
//                                           );
//                                         },
//                                         child: Text("إلغاء الطلب",
//                                             style: Get.textTheme.displayLarge!.copyWith(fontSize: 16.sp)),
//                                       ),
//                                     ],
//                                   ),
//                                   20.verticalSpace,
//                                   Text("تفاصيل الطلب", style: Get.textTheme.titleMedium),
//                                   20.verticalSpace,
//                                   FromToWidget(
//                                     from: controller.orderUserModel.order!.fromPlace.orEmpty(),
//                                     to: controller.orderUserModel.toPlace.orEmpty(),
//                                     space: 10.h,
//                                   ),
//                                   20.verticalSpace,
//                                   buildDivider(),
//                                   buildRowDetails(
//                                     iconImage: IconsAssets.seats,
//                                     label: 'عدد المقاعد المحجوزة',
//                                     detail:
//                                         "${controller.orderUserModel.seatNumber.orZero()}/${controller.orderUserModel.order!.vehicle!.seatNumber.orZero()}",
//                                   ),
//                                   buildRowDetails(
//                                     iconImage: IconsAssets.pin,
//                                     label: 'مسار الرحلة',
//                                     detail: controller.orderUserModel.order!.notes ?? "لايوجد",
//                                   ),
//                                   buildRowDetails(
//                                     iconImage: IconsAssets.tripTime,
//                                     label: 'وقت الرحلة',
//                                     detail: convertFrom24To12HourTypes(currentTime: controller.orderUserModel.order!.startedAt.toString()).orEmpty(),
//                                   ),
//                                   buildRowDetails(
//                                     iconImage: IconsAssets.vehicleType,
//                                     label: 'المركبة',
//                                     detail:
//                                         "${controller.orderUserModel.order!.vehicle!.model.orEmpty()} / ${controller.orderUserModel.order!.vehicle!.color.orEmpty()} / ${controller.orderUserModel.order!.vehicle!.type}",
//                                   ),
//                                 ],
//                               )
//                             : const ShimmerCard()),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Divider buildDivider() {
//     return Divider(
//       indent: 6.w,
//       endIndent: 7.w,
//       color: ColorManger.iconLightGreyColor,
//     );
//   }
//
//   Widget buildRowDetails({required String iconImage, required String label, required String detail}) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 20.h),
//           child: Row(
//             children: [
//               SvgPicture.asset(iconImage),
//               12.horizontalSpace,
//               CustomText(text: label),
//               const Spacer(),
//               CustomText(text: detail),
//             ],
//           ),
//         ),
//         buildDivider(),
//       ],
//     );
//   }
// }
