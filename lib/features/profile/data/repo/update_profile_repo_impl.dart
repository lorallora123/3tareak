import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/profile/data/models/update_profile_request.dart';
import 'package:take_me_with_you/features/profile/data/repo/update_profile_repo.dart';

class UpdateProfileRepoImpl implements UpdateProfileRepo {
  final DataService _dataService;

  UpdateProfileRepoImpl(this._dataService);

  @override
  Future<Either<Failure, void>> updateProfile({
    required UpdateProfileRequest updateProfileRequest,
  }) async {
    return await _dataService.postData(
      endPoint: EndPoints.updateProfile,
      data: await updateProfileRequest.toJson(),
      fromJson: BaseMapResponse.fromJson,
    );
  }
}
