import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/vehicle_response.dart';
import 'package:take_me_with_you/core/models/vehicle_type_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';

abstract class VehicleSelectionRepo {
  Future<Either<Failure, VehicleTypeResponse>> getVehicleTypes();
  Future<Either<Failure, VehicleResponse>> getCaptainVehicles();
}
