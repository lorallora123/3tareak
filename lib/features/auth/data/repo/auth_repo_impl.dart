import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/auth/data/models/register_user_request.dart';
import 'package:take_me_with_you/features/auth/data/models/user_login_request.dart';
import 'package:take_me_with_you/features/auth/data/repo/auth_repo.dart';

import '../../../../core/services/failure.dart';

class AuthRepoImpl implements AuthRepo {
  final DataService _dataService;

  AuthRepoImpl(this._dataService);

  @override
  Future<Either<Failure, UserResponse>> login({required UserLoginRequest loginRequest}) async {
    return await _dataService.postData<UserResponse>(
      endPoint: EndPoints.userLogin,
      data: loginRequest.toJson(),
      fromJson: BaseMapResponse<UserResponse>.fromJson,
      fromJsonData: (json) =>
          UserResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, UserResponse>> register(
      {required RegisterUserRequest registerRequest}) async {
    return await _dataService.postData<UserResponse>(
      endPoint: EndPoints.userRegister,
      data: await registerRequest.toJson(),
      fromJson: BaseMapResponse<UserResponse>.fromJson,
      fromJsonData: (json) =>
          UserResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
