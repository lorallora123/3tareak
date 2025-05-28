import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/imports.dart';

class AvailableTripsRepoImpl implements AvailableTripsRepo {
  final DataService _dataService;

  AvailableTripsRepoImpl(this._dataService);

  @override
  Future<Either<Failure, OrderResponse>> getAvailableOrders(
      FilterOrderRequest filterOrderRequest) async {
    return await _dataService.postData<OrderResponse>(
      data: filterOrderRequest.toJson(),
      endPoint: EndPoints.getAvailableOrders,
      fromJson: BaseMapResponse<OrderResponse>.fromJson,
      fromJsonData: (json) =>
          OrderResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
