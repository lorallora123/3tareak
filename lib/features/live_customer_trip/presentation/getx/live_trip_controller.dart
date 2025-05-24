import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/models/drop_down_model.dart';
import 'package:take_me_with_you/core/models/order_response.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/cancel_customer_order_request.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/rate_captain_request.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/repo/live_trip_repo.dart';

class LiveTripController extends GetxController {
  final LiveTripRepo _liveTripRepo = instance<LiveTripRepo>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Rx<Failure> failure = Failure.Default().obs;
  late UserDataResponse userModel;

  CustomerOrder orderUserModel = CustomerOrder();

  final RxBool _isShowOnly = false.obs;
  final RxString _reasonGroupValue = "غيرت رأيي".obs;
  final RxString _reasonGroupValueTitle = "غيرت رأيي".obs;
  final List<DropDownModel> reason = [
    DropDownModel(title: "غيرت رأيي", value: "غيرت رأيي"),
    DropDownModel(title: "تأخر الكابتن", value: "تأخر الكابتن"),
    DropDownModel(title: "ماعاد بدي", value: "ماعاد بدي"),
  ];

  final RxBool _loading = false.obs;
  final RxBool _loadingCancel = false.obs;
  final RxBool _needCancel = false.obs;

  bool get isShowOnly => _isShowOnly.value;

  String get reasonGroupValue => _reasonGroupValue.value;

  String get reasonGroupValueTitle => _reasonGroupValueTitle.value;

  bool get needCancel => _needCancel.value;

  set isShowOnly(value) => _isShowOnly.value = value;

  set reasonGroupValue(value) => _reasonGroupValue.value = value;

  set reasonGroupValueTitle(value) => _reasonGroupValueTitle.value = value;

  set needCancel(bool value) {
    _needCancel.value = value;
  }

  onChangedReasonGroupValue(String? value, String titleValue) {
    reasonGroupValue = value;
    reasonGroupValueTitle = titleValue;
  }

  final RxDouble _rate = 3.0.obs;
  final RxString _status = ''.obs;

  bool get loading => _loading.value;

  bool get loadingCancel => _loadingCancel.value;

  double get rate => _rate.value;

  set loading(value) => _loading.value = value;

  set loadingCancel(value) => _loadingCancel.value = value;

  set rate(value) => _rate.value = value;

  String get status => _status.value;

  set status(String value) {
    _status.value = value;
  }

  onChanged(double value) {
    rate = value;
  }

  rateCustomer() async {
    loading = true;
    (await _liveTripRepo.rateCaptain(
            rateCaptainRequest: RateCaptainRequest(userModel.id!, rate)))
        .fold((l) => AppMessage.showToast(l.message), (r) => Get.back());
    loading = false;
  }

  cancelOrder() async {
    loadingCancel = true;
    (await _liveTripRepo.customerCancelOrder(
            cancelCustomerOrderRequest: CancelCustomerOrderRequest(
                orderUserModel.order!.id!, reasonGroupValue)))
        .fold((l) => AppMessage.showToast(l.message), (r) {
      Get.back();
      Get.back();
    });
    loadingCancel = false;
  }

  getOnGoingOrder() async {
    loading = true;
    (await _liveTripRepo.getCustomerOnGoingOrder())
        .fold((l) => {failure.value = l, AppMessage.showToast(l.message)},
            (CustomerOrder r) {
      orderUserModel = r;
    });
    loading = false;
  }

  @override
  void onInit() async {
    status = await Get.arguments;
    await getOnGoingOrder();
    super.onInit();
  }
}
