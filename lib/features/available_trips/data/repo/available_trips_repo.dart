import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/imports.dart';

abstract class AvailableTripsRepo {
  Future<Either<Failure, OrderResponse>> getAvailableOrders(
      FilterOrderRequest filterOrderRequest);
}
