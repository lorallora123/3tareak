import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class CreateTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => CreateTripController(isPrivate: Get.arguments['isPrivate']));
    Get.put(SelectAddressMapController());
  }
}
