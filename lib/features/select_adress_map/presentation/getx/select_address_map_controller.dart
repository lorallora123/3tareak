import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/imports.dart';

class SelectAddressMapController extends GetxController {
  final MapRepo _mapRepo = instance<MapRepo>();
  late GoogleMapController googleMapController;

  final RxBool _isLoading = false.obs;
  RxList<SearchResultModel> searchResult = <SearchResultModel>[].obs;

  late Rx<Marker> origin = const Marker(markerId: MarkerId("origin")).obs;
  late Rx<Marker> destination =
      const Marker(markerId: MarkerId("destination")).obs;
  late LatLng latLngPosition;
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
    latLngPosition = LatLng(position.latitude, position.longitude);
    cameraPosition = CameraPosition(target: latLngPosition, zoom: 14.4746).obs;
    addOriginMarker(latLngPosition);
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

  Future<String?> onSelectSearchMapInput(
      {required SearchResultModel selectedItem, required bool isOrigin}) async {
    var addressDetails =
        await getAddressLatLng(selectedItem.placeId.toString());
    if (addressDetails == null) return null;
    moveCamera(addressDetails);
    if (isOrigin) {
      addOriginMarker(addressDetails);
    } else {
      addDestanationMarker(addressDetails);
    }
    return selectedItem.name;
  }

  Future<void> moveCamera(LatLng? latLng) async {
    await googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(latLng!.latitude, latLng.longitude), 15));
  }

  Future<void> getAddressPredictions(String text) async {
    (await _mapRepo.getAddressPredictions(text))
        .fold((l) => AppMessage.showToast(el.tr('internalServerError')), (r) {
      searchResult.value = r;
    });
  }

  Future<LatLng?> getAddressLatLng(String placeId) async {
    return (await _mapRepo.getAddressLatLng(placeId)).fold((l) {
      AppMessage.showToast(el.tr('internalServerError'));
      return null;
    }, (r) => r);
  }

  Future<String?> getAreaName(LatLng latLng) async {
    return (await _mapRepo.getAreaName(latLng)).fold((l) {
      AppMessage.showToast(el.tr('internalServerError'));
      return null;
    }, (r) => r);
  }

  Future<String?> getDistance(LatLng latLng1, LatLng latLng2) async {
    return (await _mapRepo.getDistance(latLng1, latLng2)).fold((l) {
      AppMessage.showToast(el.tr('internalServerError'));
      return null;
    }, (r) => r);
  }

  late PolylineResult result;
  getPolyline({LatLng? firstPoint, LatLng? secondPoint}) async {
    if (polylineCoordinates.isNotEmpty) {
      polylineCoordinates.clear();
    }
    result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: Constants.googleMapKey,
        request: PolylineRequest(
            origin: PointLatLng(firstPoint!.latitude, firstPoint.longitude),
            destination:
                PointLatLng(secondPoint!.latitude, secondPoint.longitude),
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
