import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/spin/data/models/spin_request.dart';
import 'package:take_me_with_you/features/spin/data/repo/spin_repo.dart';

import '../../../../core/services/failure.dart';

class SpinRepoImpl implements SpinRepo {
  final DataService _dataService;

  SpinRepoImpl(this._dataService);

  @override
  Future<Either<Failure, BaseMapResponse>> spin(SpinRequest spinRequest) async {
    return await _dataService.postData(
        endPoint: EndPoints.spinCustomer,
        fromJson: BaseMapResponse.fromJson,
        data: {
          'rates': [spinRequest.toJson()]
        });
  }
}
