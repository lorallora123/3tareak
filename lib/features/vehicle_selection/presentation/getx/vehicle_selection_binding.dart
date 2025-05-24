import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class VehicleSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VehicleSelectionController());
  }
}
