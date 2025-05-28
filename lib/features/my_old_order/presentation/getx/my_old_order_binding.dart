import 'package:get/get.dart';

import 'my_old_order_controller.dart';

class MyOldOrdersBonding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOldOrdersController());
  }
}
