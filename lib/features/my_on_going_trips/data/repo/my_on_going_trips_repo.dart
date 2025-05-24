import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/captain_trips_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';

abstract class MyOnGoingTripsRepo {
  Future<Either<Failure, CaptainTripsResponse>> getCaptainOnGoingOrder();
}
