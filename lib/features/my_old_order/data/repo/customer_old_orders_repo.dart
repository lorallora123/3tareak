import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/customer_trips_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';

abstract class CustomerOldOrdersRepo {
  Future<Either<Failure, PaginationResponse<CustomerTripDataResponse>>>
      getCustomerOldOrders({required int page});
}
