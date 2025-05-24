import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/features/add_vehicle/data/models/add_vehicle_request.dart';

abstract class AddVehicleRepo {
  Future<Either<Failure, void>> addVehicle(
      {required AddVehicleRequest addVehicleRequest});
}
