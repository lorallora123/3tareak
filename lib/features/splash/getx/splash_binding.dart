import 'package:get/get.dart';
import 'package:take_me_with_you/features/splash/getx/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
