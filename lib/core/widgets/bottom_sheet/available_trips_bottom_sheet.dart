// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:take_me_with_you/presentation/widget/shimmer/shimmer_widget.dart';
//
// import '../../../resources/color_manger.dart';
// import '../../../resources/design_constants.dart';
// import '../../../resources/string_manger.dart';
// import '../../available_trips/getx/available_trips_controller.dart';
// import '../../available_trips/widget/trip_card.dart';
// import '../errors/content_error_widget.dart';
//
// class AvailableTripsBottomSheet extends GetView<AvailableTripsController> {
//   const AvailableTripsBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildDraggableScrollableSheet();
//   }
//
//   Widget _buildDraggableScrollableSheet() {
//     Get.lazyPut(()=>AvailableTripsController());
//     return DraggableScrollableSheet(
//       initialChildSize: 0.2,
//       minChildSize: 0.1,
//       maxChildSize: 0.55,
//       builder: (BuildContext context, ScrollController scrollController) {
//         return Container(
//           decoration: BoxDecoration(
//               color: ColorManger.white,
//               // border: Border.all(color: Colors.blue, width: 2),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15.r),
//                 topRight: Radius.circular(15.r),
//               ),
//               boxShadow: [veryLowElevation]),
//           child: Scrollbar(
//             child:
//           ),
//         );
//       },
//     );
//   }
// }
