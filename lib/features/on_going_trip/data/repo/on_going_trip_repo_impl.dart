import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/finished_trip_response.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/on_going_trip/data/models/customer_in_order_request.dart';
import 'package:take_me_with_you/features/on_going_trip/data/repo/on_going_trip_repo.dart';

import '../../../../core/services/failure.dart';

class OnGoingTripRepoImpl implements OnGoingTripRepo {
  final DataService _dataService;

  OnGoingTripRepoImpl(this._dataService);

  @override
  Future<Either<Failure, void>> customerInOrder(
      {required CustomerInOrderRequest customerInOrderRequest}) async {
    return await _dataService.postData(
      endPoint:
          "${EndPoints.customerInOrder}/${customerInOrderRequest.orderId}",
      data: customerInOrderRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
    );
  }

  @override
  Future<Either<Failure, void>> captainStartTrip({required int? id}) async {
    return await _dataService.postData(
      endPoint: "${EndPoints.captainStartOrder}/$id",
      fromJson: BaseMapResponse.fromJson,
      isPut: true,
    );
  }

  @override
  Future<Either<Failure, FinishTripResponse>> captainFinishOrder(
      {required int id}) async {
    return await _dataService.postData(
      endPoint: "${EndPoints.captainFinishOrder}/$id",
      fromJson: BaseMapResponse<FinishTripResponse>.fromJson,
      fromJsonData: (json) =>
          FinishTripResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, FinishTripResponse>> customerOutOrder(
      {required CustomerInOrderRequest customerInOrderRequest}) async {
    return await _dataService.postData(
      endPoint:
          "${EndPoints.customerOutOrder}/${customerInOrderRequest.orderId}",
      data: customerInOrderRequest.toJson(),
      fromJson: BaseMapResponse<FinishTripResponse>.fromJson,
      fromJsonData: (json) =>
          FinishTripResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, TripDateResponseUserTrip>> getOrderById(
      {required int id}) async {
    return await _dataService.getData(
      endPoint: "${EndPoints.showOrderDetails}/$id",
      fromJson: BaseMapResponse<TripDateResponseUserTrip>.fromJson,
      fromJsonData: (json) =>
          TripDateResponseUserTrip.fromJson(json as Map<String, dynamic>),
    );
  }
}
