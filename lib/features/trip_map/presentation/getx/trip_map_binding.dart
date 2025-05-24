import 'package:get/get.dart';
import 'package:take_me_with_you/features/trip_map/presentation/getx/trip_map_controller.dart';

class TripMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripMapController());
  }
}
