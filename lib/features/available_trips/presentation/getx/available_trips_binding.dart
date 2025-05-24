import 'package:get/get.dart';
import 'package:take_me_with_you/features/select_adress_map/presentation/getx/select_address_map_controller.dart';
import 'package:take_me_with_you/features/service/presentation/getx/service_controller.dart';
import 'available_trips_controller.dart';

class AvailableTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AvailableTripsController());
    Get.lazyPut(() => ServiceController());
    Get.put(SelectAddressMapController());
  }
}
