import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/widgets/custom_swipe_buttons/swipe_button.dart';
import 'package:take_me_with_you/core/widgets/custom_swipe_buttons/vertical_swipe_button.dart';
import 'package:take_me_with_you/core/widgets/dialog/finish_trip_dialog.dart';
import 'package:take_me_with_you/core/widgets/dialog/rate_customer_dialog/getx/call_customer_rate_dialog.dart';
import 'package:take_me_with_you/core/widgets/dialog/success_delivered_customer.dart';
import 'package:take_me_with_you/features/on_going_trip/data/models/customer_in_order_request.dart';
import 'package:take_me_with_you/features/on_going_trip/data/repo/on_going_trip_repo.dart';
import 'package:take_me_with_you/features/service/presentation/getx/service_controller.dart';

class OnGoingTripController extends GetxController
    with GetTickerProviderStateMixin {
  final OnGoingTripRepo _onGoingTripRepo = instance<OnGoingTripRepo>();

  late TabController tabController;
  late bool thereAreOrder;
  final RxInt _index = 0.obs;
  late TripDataResponse trip;
  final RxBool _loading = false.obs;
  late int orderId;

  int get indexPage => _index.value;

  bool get loading => _loading.value;

  set indexPage(value) => _index.value = value;

  set loading(value) => _loading.value = value;

  selectIndex(int index) {
    indexPage = index;
    tabController.index = index;
  }

  getSeatsNumber() {
    int seats = 0;
    if (trip.customers!.isNotEmpty) {
      for (var element in trip.customers!) {
        seats += element.seatNumber!;
      }
    }
    return seats;
  }

  captainStartTrip() async {
    final startTripController = Get.find<SwipeButtonController>(tag: "99");
    startTripController.loading();
    (await _onGoingTripRepo.captainStartTrip(id: trip.id!)).fold((l) {
      AppMessage.showToast(l.message);
      startTripController.failure();
    }, (r) async {
      await Get.find<ServiceController>().startOrder(trip.id!);
      startTripController.success();
      getOrderById();
    });
  }

  customerInOrder(int index) async {
    final swipeController = Get.find<SwipeButtonController>(tag: "$index");
    swipeController.loading();
    (await _onGoingTripRepo.customerInOrder(
            customerInOrderRequest: CustomerInOrderRequest(
                orderId: trip.id,
                customerId: trip.customers![index].customer!.id)))
        .fold((l) {
      AppMessage.showToast(l.message);
      swipeController.failure();
    }, (r) async {
      await Get.find<ServiceController>()
          .approveJoinRequest(trip.id!, trip.customers![index].customer!.id!);
      swipeController.success();
      getOrderById();
    });
  }

  captainFinishOrder() async {
    final swipeController = Get.find<VerticalSwipeButtonController>(tag: "100");
    swipeController.loading();
    (await _onGoingTripRepo.captainFinishOrder(id: trip.id!)).fold((l) {
      AppMessage.showToast(l.message);
      swipeController.failure();
    }, (r) async {
      Get.find<ServiceController>().completeOrder(r.finishedOrder!.id!);
      swipeController.success();
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      Get.dialog(FinishTripDialog(model: r.finishedOrder!));
    });
  }

  customerOutOrder(int index) async {
    final swipeController = Get.find<SwipeButtonController>(tag: "$index");
    swipeController.loading();
    (await _onGoingTripRepo.customerOutOrder(
            customerInOrderRequest: CustomerInOrderRequest(
                orderId: trip.id,
                customerId: trip.customers![index].customer!.id)))
        .fold((l) {
      AppMessage.showToast(l.message);
      swipeController.failure();
    }, (r) {
      swipeController.success();
      Get.dialog(SuccessDeliveredCustomer(
        model: r.finishedOrder!,
      )).whenComplete(
          () => callCustomerRateDialog(trip.customers![index].customer!));
    });
  }

  getOrderById() async {
    loading = true;
    (await _onGoingTripRepo.getOrderById(id: orderId)).fold((l) {
      AppMessage.showToast(l.message);
    },
        (r) => {
              trip = r.trip!,
              tabController = TabController(
                  length: trip.customers!.length + 1, vsync: this),
              thereAreOrder = trip.customers!.isNotEmpty,
            });
    loading = false;
  }

  void selectUserTab() {
    int? userId = Get.arguments['userId'];
    if (userId == null) return;
    int userIndex =
        (trip.customers ?? []).indexWhere((e) => e.userId == userId);
    if (userIndex != -1) {
      selectIndex(userIndex + 1);
    }
  }

  @override
  void onInit() async {
    orderId = Get.arguments['orderId'];
    await getOrderById();
    selectUserTab();
    tabController.addListener(() {
      indexPage = tabController.index;
    });

    super.onInit();
  }

  @override
  void dispose() {
    tabController.removeListener(() {});
    tabController.dispose();
    super.dispose();
  }

  String getCustomerStatus(String status) {
    if (status == 'join') {
      return 'في الانتظار';
    } else if (status == 'approved') {
      return 'تم صعود الزبون';
    } else {
      return 'تم التوصيل بنجاح';
    }
  }
}
