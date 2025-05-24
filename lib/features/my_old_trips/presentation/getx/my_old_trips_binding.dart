import 'package:get/get.dart';
import 'package:take_me_with_you/features/my_old_trips/presentation/getx/my_old_trips_controller.dart';
 
class MyOldTripsBonding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOldTripsController());
  }
}
