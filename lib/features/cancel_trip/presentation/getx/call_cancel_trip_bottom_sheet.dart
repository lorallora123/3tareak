import 'package:get/get.dart';
import 'package:take_me_with_you/features/cancel_trip/presentation/widgets/cancel_trip_bottom_sheet.dart';
import 'cancel_trip_controller.dart';

void callCancelTripBottomSheet(int orderId) {
  Get.lazyPut(() => CancelTripController());
  Get.find<CancelTripController>().orderId = orderId;
  Get.bottomSheet(const CancelTripBottomSheet())
      .whenComplete(() => Get.find<CancelTripController>().dispose());
}
