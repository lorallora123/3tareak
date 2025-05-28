import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/order_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/cancel_customer_order_request.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/rate_captain_request.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/models/rate_customer_request.dart';
import 'package:take_me_with_you/features/live_customer_trip/data/repo/live_trip_repo.dart';

import '../../../../core/services/failure.dart';

class LiveTripRepoImpl implements LiveTripRepo {
  final DataService _dataService;

  LiveTripRepoImpl(this._dataService);

  @override
  Future<Either<Failure, void>> rateCaptain(
      {required RateCaptainRequest rateCaptainRequest}) async {
    return await _dataService.postData(
      endPoint: "${EndPoints.rateCaptain}/${rateCaptainRequest.id}",
      data: rateCaptainRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
    );
  }

  @override
  Future<Either<Failure, void>> customerCancelOrder(
      {required CancelCustomerOrderRequest cancelCustomerOrderRequest}) async {
    return await _dataService.postData(
      endPoint:
          "${EndPoints.customerCancelOrder}/${cancelCustomerOrderRequest.id}",
      data: cancelCustomerOrderRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
    );
  }

  @override
  Future<Either<Failure, CustomerOrder>> getCustomerOnGoingOrder() async {
    return await _dataService.getData<CustomerOrder>(
      endPoint: EndPoints.getCustomerOnGoingOrder,
      fromJson: BaseMapResponse<CustomerOrder>.fromJson,
      fromJsonData: (json) =>
          CustomerOrder.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, void>> rateCustomer(
      {required List<RateCustomerRequest> rateCustomerRequests}) async {
    return await _dataService.postData(
      endPoint: EndPoints.rateCustomer,
      data: {'rates': rateCustomerRequests.map((e) => e.toJson()).toList()},
      fromJson: BaseMapResponse.fromJson,
    );
  }
}
