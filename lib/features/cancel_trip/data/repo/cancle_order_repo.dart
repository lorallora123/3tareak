import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/features/cancel_trip/data/models/cancel_order_request.dart';

abstract class CancleOrderRepo {
  Future<Either<Failure, void>> cancelOrder(
      {required CancelOrderRequest cancelOrderRequest});
}
