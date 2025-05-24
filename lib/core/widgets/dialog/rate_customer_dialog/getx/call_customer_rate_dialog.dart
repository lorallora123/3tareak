import 'package:get/get.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
 
import '../rate_customer_dialog.dart';
import 'rate_customer_controller.dart';

void callCustomerRateDialog(UserDataResponse userModel) {
  Get.lazyPut(() => RateCustomerController());
  Get.find<RateCustomerController>().userModel = userModel;
  Get.dialog(const RateCustomerDialog()).whenComplete(() => Get.find<RateCustomerController>().dispose());
}
