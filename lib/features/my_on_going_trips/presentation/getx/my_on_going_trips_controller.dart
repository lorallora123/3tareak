import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/models/captain_trips_response.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/features/my_on_going_trips/data/repo/my_on_going_trips_repo.dart';

class MyOnGoingTripsController extends GetxController {
  final MyOnGoingTripsRepo _myOnGoingTripsRepo = instance<MyOnGoingTripsRepo>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final RxBool _loading = false.obs;
  CaptainTripsResponse? captainTripsModel;
  TripDataResponse? orders;

  bool get loading => _loading.value;

  set loading(value) => _loading.value = value;

  getOnGoingOrders() async {
    loading = true;
    (await _myOnGoingTripsRepo.getCaptainOnGoingOrder()).fold(
        (l) => AppMessage.showToast(l.message),
        (r) => {
              captainTripsModel = r,
              if (captainTripsModel?.order != null)
                orders = captainTripsModel!.order!
            });
    loading = false;
  }

  @override
  void onInit() async {
    await getOnGoingOrders();
    super.onInit();
  }
}
