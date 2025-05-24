import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';

abstract class MyOldTripsRepo {
  Future<Either<Failure, PaginationResponse<TripDataResponse>>>
      getCaptainPreviousOrder({required int page});
}
