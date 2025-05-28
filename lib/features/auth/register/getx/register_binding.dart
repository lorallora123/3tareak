import 'package:get/get.dart';
import 'package:take_me_with_you/features/auth/register/getx/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
