import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/imports.dart';

abstract class MapRepo {
  Future<Either<Failure, List<SearchResultModel>>> getAddressPredictions(
      String text);
  Future<Either<Failure, LatLng>> getAddressLatLng(String placeId);
  Future<Either<Failure, String>> getAreaName(LatLng latLng);
  Future<Either<Failure, String>> getDistance(LatLng latLng1, LatLng latLng2);
}
