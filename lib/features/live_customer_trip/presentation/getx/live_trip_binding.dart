import 'package:get/get.dart';

import 'live_trip_controller.dart';

class LiveTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveTripController());
    // Get.lazyPut(() => MapController());
  }
}
