import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/imports.dart';

abstract class CreateTripRepo {
  Future<Either<Failure, OrderDataResponse>> createOrder(
      {required CreateTripRequest createTripRequest, required bool isPrivate});
}
