import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/finished_trip_response.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/features/on_going_trip/data/models/customer_in_order_request.dart';

abstract class OnGoingTripRepo {
  Future<Either<Failure, void>> customerInOrder(
      {required CustomerInOrderRequest customerInOrderRequest});
  Future<Either<Failure, void>> captainStartTrip({required int id});
  Future<Either<Failure, FinishTripResponse>> captainFinishOrder(
      {required int id});
  Future<Either<Failure, FinishTripResponse>> customerOutOrder(
      {required CustomerInOrderRequest customerInOrderRequest});
  Future<Either<Failure, TripDateResponseUserTrip>> getOrderById(
      {required int id});
}
