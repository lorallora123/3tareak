import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/log_out_response.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/service/data/models/contact_us_request.dart';
import 'package:take_me_with_you/features/service/data/models/rate_us_request.dart';
import 'package:take_me_with_you/features/service/data/repo/service_repo.dart';

import '../../../../core/services/failure.dart';

class ServiceRepoImpl implements ServiceRepo {
  final DataService _dataService;

  ServiceRepoImpl(this._dataService);

  @override
  Future<Either<Failure, LogOutResponse>> logout() async {
    return await _dataService.postData<LogOutResponse>(
      endPoint: EndPoints.userLogout,
      fromJson: BaseMapResponse<LogOutResponse>.fromJson,
      fromJsonData: (json) =>
          LogOutResponse.fromJson(json as Map<String, dynamic>?),
    );
  }

  @override
  Future<Either<Failure, UserResponse>> getProfile() async {
    return await _dataService.getData<UserResponse>(
      endPoint: EndPoints.getProfile,
      fromJson: BaseMapResponse<UserResponse>.fromJson,
      fromJsonData: (json) =>
          UserResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, BaseMapResponse>> contactUs(
      {required ContactUsRequest contactUsRequest}) async {
    return await _dataService.postData(
      endPoint: EndPoints.contactUs,
      data: contactUsRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
    );
  }

  @override
  Future<Either<Failure, BaseMapResponse>> rateUs(
      {required List<RateUsRequest> rateUsRequests}) async {
    return await _dataService.postData(
      endPoint: EndPoints.rateCustomer,
      data: {'rates': rateUsRequests.map((e) => e.toJson()).toList()},
      fromJson: BaseMapResponse.fromJson,
    );
  }

 
}
