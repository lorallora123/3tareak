// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/features/my_old_trips/data/repo/my_old_trips_repo.dart';

class MyOldTripsController extends GetxController {
  final MyOldTripsRepo _myOldTripsRepo = instance<MyOldTripsRepo>();

  final RxBool _loading = false.obs;
  final RxBool _loadingPagination = false.obs;
  late PaginationResponse model;
  List<TripDataResponse> trips = [];
  int pageNumber = 1;
  final ScrollController scrollController = ScrollController();

  bool get loading => _loading.value;

  bool get loadingPagination => _loadingPagination.value;

  set loading(value) => _loading.value = value;

  set loadingPagination(value) => _loadingPagination.value = value;

  getPreviousOrders() async {
    loading = true;
    (await _myOldTripsRepo.getCaptainPreviousOrder(page: pageNumber)).fold(
        (l) => AppMessage.showToast(l.message),
        (r) => {
              model = r,
              model.data!.forEach((element) {
                trips.add(element as TripDataResponse);
              }),
              pageNumber += 1
            });
    loading = false;
  }

  getPaginationOrders() async {
    if (model.nextPageUrl!.isNotEmpty) {
      loadingPagination = true;
      (await _myOldTripsRepo.getCaptainPreviousOrder(page: pageNumber)).fold(
          (l) => AppMessage.showToast(l.message),
          (r) => {
                model = r,
                model.data!.forEach((element) {
                  trips.add(element as TripDataResponse);
                }),
                pageNumber += 1
              });
      loadingPagination = false;
    }
  }

  @override
  void onInit() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getPaginationOrders();
      }
    });
    await getPreviousOrders();
    super.onInit();
  }
}
