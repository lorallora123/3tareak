import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/my_old_trips/data/repo/my_old_trips_repo.dart';

import '../../../../core/services/failure.dart';

class MyOldTripsRepoImpl implements MyOldTripsRepo {
  final DataService _dataService;

  MyOldTripsRepoImpl(this._dataService);

  @override
  Future<Either<Failure, PaginationResponse<TripDataResponse>>>
      getCaptainPreviousOrder({required int page}) async {
    return await _dataService.getData<PaginationResponse<TripDataResponse>>(
      endPoint: EndPoints.captainPreviousOrder,
      queryParameters: {'page': page},
      fromJson: BaseMapResponse<PaginationResponse<TripDataResponse>>.fromJson,
      fromJsonData: (json) => PaginationResponse<TripDataResponse>.fromJson(
        json as Map<String, dynamic>,
        (json) => TripDataResponse.fromJson(json as Map<String, dynamic>),
      ),
    );
  }
}
