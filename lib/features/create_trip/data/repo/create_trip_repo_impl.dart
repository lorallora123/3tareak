import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/imports.dart';

class CreateTripRepoImpl implements CreateTripRepo {
  final DataService _dataService;

  CreateTripRepoImpl(this._dataService);

  @override
  Future<Either<Failure, OrderDataResponse>> createOrder(
      {required CreateTripRequest createTripRequest,
      required bool isPrivate}) async {
    return await _dataService.postData<OrderDataResponse>(
      endPoint:
          isPrivate ? EndPoints.createPrivateOrder : EndPoints.createOrder,
      data: isPrivate
          ? createTripRequest.privateToJson()
          : createTripRequest.toJson(),
      fromJson: BaseMapResponse<OrderDataResponse>.fromJson,
      fromJsonData: (json) =>
          OrderDataResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
