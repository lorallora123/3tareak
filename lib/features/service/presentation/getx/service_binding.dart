import 'package:get/get.dart';
import 'package:take_me_with_you/features/service/presentation/getx/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceController());
  }
}
