import 'package:take_me_with_you/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class AvailableTripsController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final AvailableTripsRepo _availableTripsRepo = instance<AvailableTripsRepo>();
  final VehicleSelectionRepo _vehicleSelectionRepo =
      instance<VehicleSelectionRepo>();
  final RxBool _isSecond = false.obs;
  String distance = "0.0";
  bool get isSecond => _isSecond.value;
  set isSecond(value) => _isSecond.value = value;

  final Rx<Failure> failure = Failure.Default().obs;
  final RxString _tripFor = ''.obs;

  final RxBool _updatePos1Loading = false.obs;
  final RxBool _updatePos2Loading = false.obs;

  bool get updatePos1Loading => _updatePos1Loading.value;
  set updatePos1Loading(value) => _updatePos1Loading.value = value;

  bool get updatePos2Loading => _updatePos2Loading.value;
  set updatePos2Loading(value) => _updatePos2Loading.value = value;

  LatLng? pos1;
  LatLng? pos2;

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

  OrderResponse orderModel = OrderResponse();
  VehicleTypeResponse vehicleTypeModel = VehicleTypeResponse();

  FilterOrderRequest filterOrderRequest = FilterOrderRequest(vehicleTypeId: []);

  late RxString timeDate;
  final TextEditingController numSeats = TextEditingController(text: "");
  final TextEditingController fromController = TextEditingController(text: "");
  final TextEditingController toController = TextEditingController(text: "");
  final RxBool _typeEmpty = false.obs;

  final RxBool _loading = false.obs;

  String get time => timeDate.value;

  bool get loading => _loading.value;

  set loading(value) => _loading.value = value;

  final RxBool _loadingType = false.obs;

  bool get loadingType => _loadingType.value;

  set loadingType(value) => _loadingType.value = value;

  set time(value) => timeDate.value = value;

  bool get typeEmpty => _typeEmpty.value;

  String get tripFor => _tripFor.value;
  set tripFor(value) => _tripFor.value = value;

  set typeEmpty(bool value) {
    _typeEmpty.value = value;
  }

  getVehicleType() async {
    loadingType = true;
    (await _vehicleSelectionRepo.getVehicleTypes()).fold(
        (l) => AppMessage.showToast(l.message), (r) => vehicleTypeModel = r);
    loadingType = false;
  }

  onVehicleSelected(int index, bool press) {
    if (press) {
      filterOrderRequest.vehicleTypeId.add(index);
      typeEmpty = true;
    } else {
      filterOrderRequest.vehicleTypeId.removeWhere((int item) => item == index);
      if (filterOrderRequest.vehicleTypeId.isEmpty) {
        typeEmpty = false;
      }
    }
  }

  void getCurrentLocationName(LatLng latLng, String? name) {
    if (isSecond) {
      toController.text = name ?? toController.text;
      updatePos2(latLng);
    } else {
      fromController.text = name ?? fromController.text;
      updatePos1(latLng);
    }
  }

  customerOrders() async {
    loading = true;
    // for (int i = 0; i < filterOrderRequest.vehicleTypeId.length; i++) {
    //   print(filterOrderRequest.vehicleTypeId[i]);
    // }

    filterOrderRequest.from = fromController.text;
    filterOrderRequest.to = toController.text;
    if (numSeats.text.isNotEmpty) {
      filterOrderRequest.seatsNum = int.parse(numSeats.text);
    }
    filterOrderRequest.tripFor = tripFor;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('yyyy/MM/dd').format(now);
    filterOrderRequest.date = formattedTime;

    DateFormat format = DateFormat.jm();
    String hour = now.hour.toString();
    String minute = now.minute.toString();
    if (timeDate.value == "Now") {
      String formattedTime = format.format(now);
      String amOrPm = formattedTime.substring(formattedTime.length - 2);

      if (hour.length == 1) {
        hour = "0$hour";
      }
      if (minute.length == 1) {
        minute = "0$minute";
      }
      if (int.parse(hour) > 12) {
        hour = (int.parse(hour) - 10).toString();
      }
      filterOrderRequest.time =
          convertFrom12To24HourTypes(currentTime: "$hour:$minute $amOrPm");
    } else {
      filterOrderRequest.time = timeDate.value;
    }

    (await _availableTripsRepo.getAvailableOrders(filterOrderRequest)).fold(
      (left) => {failure.value = left, AppMessage.showToast(left.message)},
      (right) async => orderModel = right,
    );
    // log('logggggggggggggg ${orderModel.}');
    loading = false;
  }

  @override
  void onInit() async {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);
    timeDate = formattedTime.obs;
    await customerOrders();
    // await getVehicleType();
    super.onInit();
  }

  changetripFor(String tripForValue) {
    if (tripFor == tripForValue) {
      tripFor = '';
    } else {
      tripFor = tripForValue;
    }
  }
}
