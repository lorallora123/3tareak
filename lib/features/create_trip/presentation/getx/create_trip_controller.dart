// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:take_me_with_you/imports.dart';

class CreateTripController extends GetxController {
  final bool isPrivate;
  CreateTripController({required this.isPrivate});

  final CreateTripRepo _createTripRepo = instance<CreateTripRepo>();

  final TextEditingController wantedSeatsController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final RxString _time = "${DateTime.now().hour}:${DateTime.now().minute}".obs;

  final RxBool _loading = false.obs;
  final RxBool _updatePos1Loading = false.obs;
  final RxBool _updatePos2Loading = false.obs;
  final RxInt _seatsNumber = 0.obs;

  final RxString _tripFor = ''.obs;
  String distance = "0.0";

  LatLng? pos1;
  LatLng? pos2;

  String get time => _time.value;

  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  bool get updatePos1Loading => _updatePos1Loading.value;
  set updatePos1Loading(value) => _updatePos1Loading.value = value;

  bool get updatePos2Loading => _updatePos2Loading.value;
  set updatePos2Loading(value) => _updatePos2Loading.value = value;

  int get seatsNumber => _seatsNumber.value;

  String get tripFor => _tripFor.value;

  set time(value) => _time.value = value;

  set seatsNumber(value) => _seatsNumber.value = value;

  set tripFor(value) => _tripFor.value = value;

  updatePos1(LatLng pos, {String? title}) async {
    updatePos1Loading = true;
    fromController.text = title ??
        await Get.find<SelectAddressMapController>().getAreaName(pos) ??
        fromController.text;
    pos1 = pos;
    updatePos1Loading = false;
    update(['LAT']);
  }

  updatePos2(LatLng pos, {String? title}) async {
    updatePos2Loading = true;
    toController.text = title ??
        await Get.find<SelectAddressMapController>().getAreaName(pos) ??
        toController.text;
    pos2 = pos;
    updatePos2Loading = false;
    update(['LAT']);
  }

  createOrder({required bool isPrivate}) async {
    if (seatsNumber != 0 || isPrivate) {
      if (pos1 != null) {
        if (pos2 != null) {
          loading = true;
          distance = await Get.find<SelectAddressMapController>()
                  .getDistance(pos1!, pos2!) ??
              '0.0';
          if (distance == '0.0') {
            AppMessage.showToast("حدث خطأ اثناء حساب المسافة,اعد المحاولة !");
          } else {
            (await _createTripRepo.createOrder(
              createTripRequest: CreateTripRequest(
                startedAt: time,
                vehicleId: isPrivate
                    ? null
                    : Get.find<VehicleSelectionController>()
                        .selectedVehicle
                        .value
                        .id,
                fromPlace: fromController.text,
                toPlace: toController.text,
                lat1: pos1!.latitude,
                lng1: pos1!.longitude,
                lat2: pos2!.latitude,
                lng2: pos2!.longitude,
                seatNumber: isPrivate
                    ? wantedSeatsController.text
                    : seatsNumber.toString(),
                notes: noteController.text,
                //TODO distance: distance,
                distance: "3",
                tripFor: tripFor,
                polyline:
                    Get.find<SelectAddressMapController>().getEncodedPolyline,
              ),
              isPrivate: isPrivate,
            ))
                .fold((l) => AppMessage.showToast(l.message), (r) {
              Get.find<ServiceController>().createOrder(r.id!);
              Get.find<ServiceController>().joinRequest(r.id!, 'driver', pos1!);
              Get.offNamed(AppRoutes.myOnGoingTripsRoute);
            });
          }
          loading = false;
        } else {
          AppMessage.showToast('الرجاء اختيار مكان نهاية الرحلة على الخريطة');
        }
      }
    }
  }

  changetripFor(String tripForValue) {
    if (tripFor == tripForValue) {
      tripFor = '';
    } else {
      tripFor = tripForValue;
    }
  }
}
