import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/payment_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/features/trip_details/data/models/join_order_request.dart';
import 'package:take_me_with_you/features/trip_details/data/models/payment_confirmation_request.dart';
import 'package:take_me_with_you/features/trip_details/data/models/payment_request.dart';

abstract class TripDetailsRepo {
  Future<Either<Failure, BaseMapResponse>> joinOrder(
      {required JoinOrderRequest joinOrderRequest});
  Future<Either<Failure, PaymentResponse>> electronicPayment(
      {required PaymentRequest paymentRequest});
  Future<Either<Failure, BaseMapResponse>> electronicPaymentConfirmation(
      {required PaymentConfirmationRequest paymentConfirmationRequest});
}
