import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/imports.dart';

class MapRepoImpl implements MapRepo {
  final DataService _dataService;

  MapRepoImpl(this._dataService);

  @override
  Future<Either<Failure, List<SearchResultModel>>> getAddressPredictions(
      String text) async {
    return (await _dataService.sendRequest(
      url: "https://maps.googleapis.com/maps/api/place/autocomplete/json",
      data: {
        'language': instance<AppPreferences>().getAppLanguage(),
        'input': text,
        'key': Constants.googleMapKey,
      },
    ))
        .fold(
      (l) => Left(l),
      (response) {
        List<SearchResultModel> searchResult = [];
        for (var item in response['predictions']) {
          var prediction = Prediction.fromJson(item);
          searchResult.add(SearchResultModel(
              type: 'address',
              name: prediction.description,
              placeId: prediction.placeId));
        }
        return Right(searchResult);
      },
    );
  }

  @override
  Future<Either<Failure, LatLng>> getAddressLatLng(String placeId) async {
    return (await _dataService.sendRequest(
      url: "https://maps.googleapis.com/maps/api/place/details/json",
      data: {
        'language': instance<AppPreferences>().getAppLanguage(),
        'placeid': placeId,
        'key': Constants.googleMapKey,
      },
    ))
        .fold(
      (l) => Left(l),
      (response) {
        var address = response['result']['geometry']['location'];
        return Right(LatLng(address['lat'], address['lng']));
      },
    );
  }

  @override
  Future<Either<Failure, String>> getAreaName(LatLng latLng) async {
    return (await _dataService.sendRequest(
      url: 'https://maps.googleapis.com/maps/api/geocode/json',
      data: {
        'language': instance<AppPreferences>().getAppLanguage(),
        'latlng': '${latLng.latitude},${latLng.longitude}',
        'key': Constants.googleMapKey,
      },
    ))
        .fold(
      (l) => Left(l),
      (response) {
        List<dynamic> results = response['results'];
        if (results.isNotEmpty) {
          var addressComponents = results.first['address_components'];
          for (var component in addressComponents) {
            List<dynamic> types = component['types'];
            if (types.contains('neighborhood') ||
                types.contains('route') ||
                types.contains('sublocality') ||
                types.contains('locality')) {
              return Right(component['long_name'].toString());
            }
          }
        }
        return Left(DataSource.notFound.getFailure());
      },
    );
  }

  @override
  Future<Either<Failure, String>> getDistance(
      LatLng latLng1, LatLng latLng2) async {
    return (await _dataService.sendRequest(
      url: 'https://maps.googleapis.com/maps/api/distancematrix/json',
      data: {
        'language': instance<AppPreferences>().getAppLanguage(),
        'origins': '${latLng1.latitude},${latLng1.longitude}',
        'destinations': '${latLng2.latitude},${latLng2.longitude}',
        'key': Constants.googleMapKey,
      },
    ))
        .fold(
      (l) => Left(l),
      (response) {
        try {
          String distanceText =
              response['rows'][0]['elements'][0]['distance']['text'];

          return Right(extractNumbers(distanceText));
        } catch (e) {
          return Left(DataSource.notFound.getFailure());
        }
      },
    );
  }
}
