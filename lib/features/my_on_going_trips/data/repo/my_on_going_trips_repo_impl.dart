import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/captain_trips_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/my_on_going_trips/data/repo/my_on_going_trips_repo.dart';

import '../../../../core/services/failure.dart';

class MyOnGoingTripsRepoImpl implements MyOnGoingTripsRepo {
  final DataService _dataService;

  MyOnGoingTripsRepoImpl(this._dataService);

  @override
  Future<Either<Failure, CaptainTripsResponse>> getCaptainOnGoingOrder() async {
    return await _dataService.getData<CaptainTripsResponse>(
      endPoint: EndPoints.captainOnGoingOrder,
      fromJson: BaseMapResponse<CaptainTripsResponse>.fromJson,
      fromJsonData: (json) =>
          CaptainTripsResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
