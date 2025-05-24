import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/order_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/cancel_customer_order_request.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/rate_captain_request.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/rate_customer_request.dart';

abstract class LiveTripRepo {
  Future<Either<Failure, void>> rateCaptain(
      {required RateCaptainRequest rateCaptainRequest});
  Future<Either<Failure, void>> customerCancelOrder(
      {required CancelCustomerOrderRequest cancelCustomerOrderRequest});
  Future<Either<Failure, CustomerOrder>> getCustomerOnGoingOrder();
  Future<Either<Failure, void>> rateCustomer(
      {required List<RateCustomerRequest> rateCustomerRequests});
}
