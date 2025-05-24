import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/log_out_response.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/features/service/data/models/contact_us_request.dart';
import 'package:take_me_with_you/features/service/data/models/rate_us_request.dart';

abstract class ServiceRepo {
  Future<Either<Failure, LogOutResponse>> logout();
  Future<Either<Failure, UserResponse>> getProfile();
  Future<Either<Failure, BaseMapResponse>> contactUs(
      {required ContactUsRequest contactUsRequest});
  Future<Either<Failure, BaseMapResponse>> rateUs(
      {required List<RateUsRequest> rateUsRequests});
}
