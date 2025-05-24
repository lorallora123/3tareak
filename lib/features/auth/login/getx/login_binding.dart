import 'package:get/get.dart';
import 'package:take_me_with_you/features/auth/login/getx/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
