import 'package:get/get.dart';
import 'package:take_me_with_you/features/select_adress_map/presentation/getx/select_address_map_controller.dart';

import 'trip_details_controller.dart';

class TripDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripDetailsController());
    Get.lazyPut(() => SelectAddressMapController());
  }
}
