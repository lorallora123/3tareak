import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/features/profile/data/models/update_profile_request.dart';

abstract class UpdateProfileRepo {
  Future<Either<Failure, void>> updateProfile({
    required UpdateProfileRequest updateProfileRequest,
  });
}
