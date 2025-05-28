import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/cancel_trip/data/models/cancel_order_request.dart';
import 'package:take_me_with_you/features/cancel_trip/data/repo/cancle_order_repo.dart';

import '../../../../core/services/failure.dart';

class CancleOrderRepoImpl implements CancleOrderRepo {
  final DataService _dataService;

  CancleOrderRepoImpl(this._dataService);

  @override
  Future<Either<Failure, void>> cancelOrder(
      {required CancelOrderRequest cancelOrderRequest}) async {
    return await _dataService.postData(
      endPoint: "${EndPoints.captainCancelOrder}/${cancelOrderRequest.id}",
      data: cancelOrderRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
    );
  }
}
