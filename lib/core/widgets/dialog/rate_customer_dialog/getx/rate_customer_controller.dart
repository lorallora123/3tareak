import 'package:get/get.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/rate_customer_request.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/repo/live_trip_repo.dart';

class RateCustomerController extends GetxController {
  final LiveTripRepo _liveTripRepo = instance<LiveTripRepo>();

  late UserDataResponse userModel;

  final RxBool _loading = false.obs;
  final RxDouble _rate = 3.0.obs;

  bool get loading => _loading.value;

  double get rate => _rate.value;

  set loading(value) => _loading.value = value;

  set rate(value) => _rate.value = value;

  onChanged(double value) {
    rate = value;
  }

  rateCustomer() async {
    loading = true;
    (await _liveTripRepo.rateCustomer(
      rateCustomerRequests: [
        RateCustomerRequest(userId: userModel.id!, rate: rate, type: 'customer')
      ],
    ))
        .fold(
            (l) => AppMessage.showToast(l.message),
            (r) => {
                  Get.back(),
                  Get.offNamedUntil(AppRoutes.serviceRoute, (route) => false),
                });
    loading = false;
  }
}
