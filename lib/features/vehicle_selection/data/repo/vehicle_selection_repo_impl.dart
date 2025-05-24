import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/vehicle_response.dart';
import 'package:take_me_with_you/core/models/vehicle_type_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/vehicle_selection/data/repo/vehicle_selection_repo.dart';

import '../../../../core/services/failure.dart';

class VehicleSelectionRepoImpl implements VehicleSelectionRepo {
  final DataService _dataService;

  VehicleSelectionRepoImpl(this._dataService);

  @override
  Future<Either<Failure, VehicleTypeResponse>> getVehicleTypes() async {
    return await _dataService.getData<VehicleTypeResponse>(
      endPoint: EndPoints.showVehicleTypes,
      fromJson: BaseMapResponse<VehicleTypeResponse>.fromJson,
      fromJsonData: (json) =>
          VehicleTypeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, VehicleResponse>> getCaptainVehicles() async {
    return await _dataService.getData<VehicleResponse>(
      endPoint: EndPoints.showCaptainVehicles,
      fromJson: BaseMapResponse<VehicleResponse>.fromJson,
      fromJsonData: (json) =>
          VehicleResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
