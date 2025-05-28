import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/cancel_trip/data/models/cancel_order_request.dart';
import 'package:take_me_with_you/features/cancel_trip/data/repo/cancle_order_repo.dart';
import 'package:take_me_with_you/features/my_on_going_trips/presentation/getx/my_on_going_trips_controller.dart';

class CancelTripController extends GetxController {
  final CancleOrderRepo _cancleOrderRepo = instance<CancleOrderRepo>();
  final RxBool _isFirst = true.obs;
  final RxBool _loading = false.obs;
  String _cancelReason = '';
  late int orderId;

  bool get loading => _loading.value;

  bool get isFirst => _isFirst.value;

  set isFirst(value) => _isFirst.value = value;

  set loading(value) => _loading.value = value;

  final List<DropdownMenuItem> items = [
    DropdownMenuItem(
        value: el.tr(AppStrings.iChangedMyMind),
        child: CustomText(
          text: el.tr(AppStrings.iChangedMyMind),
          style: Get.theme.textTheme.titleMedium!,
        )),
    DropdownMenuItem(
        value: el.tr(AppStrings.noFuelAvailable),
        child: CustomText(
          text: el.tr(AppStrings.noFuelAvailable),
          style: Get.theme.textTheme.titleMedium!,
        )),
  ];

  goToSecond() {
    isFirst = false;
  }

  onChangedCancelReason(value) {
    _cancelReason = value;
  }

  cancelOrder() async {
    loading = true;
    (await _cancleOrderRepo.cancelOrder(
            cancelOrderRequest: CancelOrderRequest(_cancelReason, orderId)))
        .fold((l) => AppMessage.showToast(l.message), (r) async {
      Get.back();
      Get.find<MyOnGoingTripsController>().captainTripsModel = null;
      Get.find<MyOnGoingTripsController>().orders = null;
      await Get.find<MyOnGoingTripsController>().getOnGoingOrders();
    });
    loading = false;
  }
}
