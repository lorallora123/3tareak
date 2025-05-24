import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/user_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/features/auth/data/models/register_user_request.dart';
import 'package:take_me_with_you/features/auth/data/models/user_login_request.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserResponse>> login(
      {required UserLoginRequest loginRequest});

  Future<Either<Failure, UserResponse>> register(
      {required RegisterUserRequest registerRequest});
}
