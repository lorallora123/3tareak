import 'package:get/get.dart';
import 'package:take_me_with_you/features/on_boarding/getx/on_boarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingController());
  }
}
