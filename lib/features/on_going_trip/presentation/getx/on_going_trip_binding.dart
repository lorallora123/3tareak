import 'package:get/get.dart';
import 'package:take_me_with_you/features/on_going_trip/presentation/getx/on_going_trip_controller.dart';

class OnGoingTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnGoingTripController());
  }
}
