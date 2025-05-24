import 'package:get/get.dart';
import 'package:take_me_with_you/features/my_on_going_trips/presentation/getx/my_on_going_trips_controller.dart';

class MyOnGoingTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOnGoingTripsController());
  }
}
