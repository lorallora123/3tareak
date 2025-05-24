// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
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
// import '../../widget/app_image.dart';
// import '../../widget/custom_swipe_buttons/call_swipe_button.dart';
// import '../../widget/custom_text.dart';
// import '../../widget/errors/content_error_widget.dart';
// import '../../widget/from_to_widget.dart';
// import '../getx/live_trip_controller.dart';
//
// class CaptainDetailsBottomSheet extends GetView<LiveTripController> {
//   const CaptainDetailsBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildDraggableScrollableSheet();
//   }
//
//   Widget _buildDraggableScrollableSheet() {
//     return DraggableScrollableSheet(
//       initialChildSize: 0.3,
//       minChildSize: 0.3,
//       maxChildSize: 0.8,
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
//                     top: -20,
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
//                     height: 0.90.sh,
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
//                             ? Stack(
//                                 children: [
//                                   Positioned.fill(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         buildCaptainInfo(),
//                                         8.horizontalSpace,
//                                         buildCarInfo(),
//                                         65.verticalSpace,
//                                         buildDivider(),
//                                         12.verticalSpace,
//                                         Text("تفاصيل الطلب",
//                                             style: Get.textTheme.titleLarge!.copyWith(fontSize: 18.sp)),
//                                         20.verticalSpace,
//                                         FromToWidget(
//                                           from: controller.orderUserModel.order!.fromPlace.orEmpty(),
//                                           to: controller.orderUserModel.order!.toPlace.orEmpty(),
//                                           space: 10.h,
//                                         ),
//                                         20.verticalSpace,
//                                         buildDivider(),
//                                         buildRowDetails(
//                                           iconImage: IconsAssets.seats,
//                                           label: 'عدد المقاعد المحجوزة',
//                                           detail:
//                                               "${controller.orderUserModel.seatNumber.orZero()}/${controller.orderUserModel.order?.vehicle?.seatNumber.orZero()}",
//                                         ),
//                                         buildRowDetails(
//                                           iconImage: IconsAssets.pin,
//                                           label: 'مسار الرحلة',
//                                           detail: controller.orderUserModel.order?.notes ?? "لا يوجد",
//                                         ),
//                                         buildRowDetails(
//                                           iconImage: IconsAssets.pin,
//                                           label: 'وقت الرحلة',
//                                           detail: convertFrom24To12HourTypes(currentTime: controller.orderUserModel.order!.startedAt.toString()).orEmpty(),
//                                         ),
//                                         buildRowDetails(
//                                           iconImage: IconsAssets.pin,
//                                           label: 'كلفة الرحلة',
//                                           detail: "${controller.orderUserModel.order!.total! * controller.orderUserModel.seatNumber!}",
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 135.h,
//                                     left: 1,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         CallSwipeButton(
//                                           isCaptain: false,
//                                           phone: controller.orderUserModel.order?.captain?.user?.phoneNumber ?? "",
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : SizedBox(
//                                 height: Get.height,
//                                 width: Get.width,
//                                 child: const Center(
//                                   child: CupertinoActivityIndicator(),
//                                 ),
//                               )),
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
//   Column buildCarInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SvgPicture.asset(ImageAssets.car),
//         CustomText(
//           text:
//               "${controller.orderUserModel.order!.vehicle!.model.orEmpty()} / ${controller.orderUserModel.order!.vehicle!.color.orEmpty()} / ${controller.orderUserModel.order!.vehicle!.type?.type ?? ""}",
//         ),
//         CustomText(
//           text: controller.orderUserModel.order!.vehicle!.boardNumber.toString(),
//           style: Get.textTheme.displayMedium,
//         ),
//       ],
//     );
//   }
//
//   Row buildCaptainInfo() {
//     return Row(
//       children: [
//         if (controller.orderUserModel.order?.captain != null)
//           AppImage(
//             width: 60.w,
//             height: 60.w,
//             imageUrl: controller.orderUserModel.order?.captain?.user?.image ?? "",
//             boxFit: BoxFit.cover,
//           ),
//         15.horizontalSpace,
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomText(text: controller.orderUserModel.order?.captain?.user?.fullName ?? ""),
//
//           ],
//         )
//       ],
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
