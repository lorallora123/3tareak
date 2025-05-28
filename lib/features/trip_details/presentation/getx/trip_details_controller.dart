// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/core/models/payment_response.dart';
import 'package:take_me_with_you/features/trip_details/data/models/join_order_request.dart';
import 'package:take_me_with_you/features/trip_details/data/models/payment_confirmation_request.dart';
import 'package:take_me_with_you/features/trip_details/data/models/payment_request.dart';
import 'package:take_me_with_you/features/trip_details/data/repo/trip_details_repo.dart';
import 'package:take_me_with_you/imports.dart';

class TripDetailsController extends GetxController {
  double _safeParse(String? value) {
    if (value == null || value.trim().isEmpty) {
      log(" قيمة غير صالحة للتحويل إلى double: '$value'");
      return 0.0;
    }
    return double.tryParse(value) ?? 0.0;
  }

  late GoogleMapController mapController;
  final TripDetailsRepo _tripDetailsRepo = instance<TripDetailsRepo>();
  final VerticalSwipeButtonController verticalSwipeButtonController =
      VerticalSwipeButtonController();
  JoinOrderRequest joinOrderRequest = JoinOrderRequest();
  late OrderDataResponse orderData;
  PolylinePoints polylinePoints = PolylinePoints();
  RxMap<PolylineId, Polyline> polyLines = RxMap<PolylineId, Polyline>({});
  List<LatLng> polylineCoordinates = [];
  late Rx<Marker> origin = const Marker(markerId: MarkerId("origin")).obs;
  late Rx<Marker> destination =
      const Marker(markerId: MarkerId("destination")).obs;

  final RxInt _index = 1.obs;
  final RxInt _numSeats = 0.obs;
  final RxBool _loading = false.obs;
  late LatLng tripCameraPosition;
  bool get loading => _loading.value;

  set loading(value) => _loading.value = value;

  int get numSeats => _numSeats.value;

  set numSeats(int value) {
    _numSeats.value = value;
  }

  int get index => _index.value;

  set index(int value) {
    _index.value = value;
  }

  getPolyline(String? polyline) async {
    if ((polyline ?? '').isEmpty) return;

    polylineCoordinates = polylinePoints
        .decodePolyline(polyline!)
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();

    addPolyLine();
  }

  addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 2,
      color: Colors.green,
    );
    polyLines[id] = polyline;
    polyLines.refresh();
  }

  onNext() {
    index++;
  }

  onBack() {
    if (index == 1) {
      Get.offNamed(AppRoutes.availableTripsRoute);
    } else {
      index--;
    }
  }

  void setClientLatLng() {
    LatLng latLng =
        Get.find<SelectAddressMapController>().origin.value.position;
    joinOrderRequest.lat = latLng.latitude;
    joinOrderRequest.lng = latLng.longitude;
  }

  bool isClientLocationNotSelected() {
    return Get.find<SelectAddressMapController>()
            .origin
            .value
            .position
            .latitude ==
        0;
  }

  joinOrder() async {
    loading = true;
    update();
    (await _tripDetailsRepo.joinOrder(joinOrderRequest: joinOrderRequest)).fold(
        (l) {
      Get.back();
      return AppMessage.showToast(l.message);
    }, (r) {
      Get.find<ServiceController>().joinRequest(
        joinOrderRequest.orderId,
        'client',
        LatLng(joinOrderRequest.lat, joinOrderRequest.lng),
      );
      AppMessage.showToast('تم الانضمام للرحلة').then((value) {
        Get.back();
        return Get.offNamed(AppRoutes.serviceRoute);
      });
    });
    loading = false;
    update();
  }

  @override
  void onInit() async {
    orderData = Get.arguments;
    getPolyline(orderData.polyline);
    joinOrderRequest.orderId = orderData.id ?? 0;
    joinOrderRequest.from = orderData.fromPlace.toString();
    joinOrderRequest.to = orderData.toPlace.toString();
    tripCameraPosition = initCameraProcess();
    log('📍 P1 lat: ${orderData.points![1].lat}, lng: ${orderData.points![1].lng}');
    log('📍 P0 lat: ${orderData.points![0].lat}, lng: ${orderData.points![0].lng}');

    LatLng firstPoint = LatLng(
      _safeParse(orderData.points![1].lat),
      _safeParse(orderData.points![1].lng),
    );

    LatLng secondPoint = LatLng(
      _safeParse(orderData.points![0].lat),
      _safeParse(orderData.points![0].lng),
    );

    origin = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'origin'),
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), IconsAssets.locationA),
      position: LatLng(firstPoint.latitude, firstPoint.longitude),
    ).obs;
    destination = Marker(
      markerId: const MarkerId('destination'),
      infoWindow: const InfoWindow(title: 'destination'),
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), IconsAssets.locationB),
      position: LatLng(secondPoint.latitude, secondPoint.longitude),
    ).obs;
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  LatLng initCameraProcess() {
    double midLat = 0;
    double midLong = 0;
    for (Points point in orderData.points!) {
      midLong += _safeParse(point.lng);
      midLat += _safeParse(point.lat);
    }
    log(LatLng(midLat / 2, midLong / 2).toString());
    return LatLng(midLat / 2, midLong / 2);
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController customerMSISDN = TextEditingController();
  PaymentResponse paymentResponse = PaymentResponse();
  electronicPayment() async {
    if (!formKey.currentState!.validate()) return;
    loading = true;
    update();
    (await _tripDetailsRepo.electronicPayment(
            paymentRequest: PaymentRequest(
                orderId: orderData.id!, customerMSISDN: customerMSISDN.text)))
        .fold((l) {
      AppMessage.showToast(l.message);
    }, (r) {
      paymentResponse = r;
      Get.back();
      Get.dialog(const AlertDialog(
        content: OtpPayDialog(),
      ));
    });
    loading = false;
    update();
  }

  electronicPaymentConfirmation(String otp) async {
    loading = true;
    update();
    (await _tripDetailsRepo.electronicPaymentConfirmation(
            paymentConfirmationRequest: PaymentConfirmationRequest(
                otp: otp, transactionId: paymentResponse.transactionId!)))
        .fold((l) {
      AppMessage.showToast(l.message);
    }, (r) {
      Get.back();
      joinOrder();
    });
    loading = false;
    update();
  }
}
