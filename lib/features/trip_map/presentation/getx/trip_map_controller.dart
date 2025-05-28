import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/imports.dart';

class TripMapController extends GetxController {
  late GoogleMapController googleMapController;

  final RxBool _isLoading = false.obs;

  late Rx<Marker> origin = const Marker(markerId: MarkerId("origin")).obs;
  late Rx<Marker> destination =
      const Marker(markerId: MarkerId("destination")).obs;
  late LatLng driverLocation;
  late final Rx<CameraPosition> cameraPosition;
  PolylinePoints polylinePoints = PolylinePoints();

  bool get isLoading => _isLoading.value;
  List<LatLng> polylineCoordinates = [];

  set isLoading(value) => _isLoading.value = value;
  RxMap<PolylineId, Polyline> polyLines = RxMap<PolylineId, Polyline>({});

  @override
  void onInit() async {
    isLoading = true;
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng clientLocation = Get.arguments['clientLocation'];
    cameraPosition = CameraPosition(target: clientLocation, zoom: 14.4746).obs;
    driverLocation = LatLng(position.latitude, position.longitude);
    addOriginMarker(driverLocation);
    addDestanationMarker(driverLocation);
    isLoading = false;
    super.onInit();
  }

  void addDestanationMarker(LatLng pos) async {
    destination.value = Marker(
      markerId: const MarkerId('locationB'),
      infoWindow: const InfoWindow(title: 'Location B'),
      // ignore: deprecated_member_use
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), IconsAssets.locationB),
      position: pos,
    );
    origin.refresh();
    try {
      getPolyline(
          firstPoint: origin.value.position,
          secondPoint: destination.value.position);
    } catch (e) {
      logPrint('eoeoeoeoe');
    }
  }

  void addOriginMarker(LatLng pos) async {
    origin.value = Marker(
      markerId: const MarkerId('locationA'),
      infoWindow: const InfoWindow(title: 'Location A'),
      // ignore: deprecated_member_use
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), IconsAssets.locationA),
      position: pos,
    );
    destination.refresh();
  }

  void onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
  }

  Future<void> moveCamera(LatLng? latLng) async {
    await googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(latLng!.latitude, latLng.longitude), 15));
  }

  late PolylineResult result;
  getPolyline({required LatLng firstPoint, required LatLng secondPoint}) async {
    if (polylineCoordinates.isNotEmpty) {
      polylineCoordinates.clear();
    }
    result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: Constants.googleMapKey,
        request: PolylineRequest(
            origin: PointLatLng(firstPoint.latitude, firstPoint.longitude),
            destination:
                PointLatLng(secondPoint.latitude, secondPoint.longitude),
            mode: TravelMode.driving));
    polylineCoordinates =
        result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
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

  get getEncodedPolyline => result.overviewPolyline;
}
