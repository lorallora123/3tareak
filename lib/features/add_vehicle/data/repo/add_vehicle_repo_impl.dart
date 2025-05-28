import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/add_vehicle/data/models/add_vehicle_request.dart';
import 'package:take_me_with_you/features/add_vehicle/data/repo/add_vehicle_repo.dart';

import '../../../../core/services/failure.dart';

class AddVehicleRepoImpl implements AddVehicleRepo {
  final DataService _dataService;

  AddVehicleRepoImpl(this._dataService);

  @override
  Future<Either<Failure, void>> addVehicle(
      {required AddVehicleRequest addVehicleRequest}) async {
    return await _dataService.postData(
      endPoint: EndPoints.addVehicle,
      fromJson: BaseMapResponse.fromJson,
      data: await addVehicleRequest.toJson(),
    );
  }
}
