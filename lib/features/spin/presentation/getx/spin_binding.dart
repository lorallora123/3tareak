import 'package:get/get.dart';
import 'package:take_me_with_you/features/spin/presentation/getx/spin_controller.dart';

class SpinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpinController());
  }
}
