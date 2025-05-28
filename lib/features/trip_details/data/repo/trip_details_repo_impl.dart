import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/payment_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/trip_details/data/models/join_order_request.dart';
import 'package:take_me_with_you/features/trip_details/data/models/payment_confirmation_request.dart';
import 'package:take_me_with_you/features/trip_details/data/models/payment_request.dart';
import 'package:take_me_with_you/features/trip_details/data/repo/trip_details_repo.dart';

import '../../../../core/services/failure.dart';

class TripDetailsRepoImpl implements TripDetailsRepo {
  final DataService _dataService;

  TripDetailsRepoImpl(this._dataService);

  @override
  Future<Either<Failure, BaseMapResponse>> joinOrder(
      {required JoinOrderRequest joinOrderRequest}) async {
    return await _dataService.postData(
      endPoint: '${EndPoints.joinOrder}${joinOrderRequest.orderId}',
      data: joinOrderRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
    );
  }

  @override
  Future<Either<Failure, PaymentResponse>> electronicPayment(
      {required PaymentRequest paymentRequest}) async {
    return await _dataService.postData<PaymentResponse>(
      endPoint: EndPoints.paymentRequest,
      data: paymentRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
      fromJsonData: (json) =>
          PaymentResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, BaseMapResponse>> electronicPaymentConfirmation(
      {required PaymentConfirmationRequest paymentConfirmationRequest}) async {
    return await _dataService.postData<BaseMapResponse>(
      endPoint: EndPoints.paymentConfirmation,
      data: paymentConfirmationRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
    );
  }
}
