import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/customer_trips_response.dart';
import 'package:take_me_with_you/core/services/data_repo.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/features/my_old_order/data/repo/customer_old_orders_repo.dart';

import '../../../../core/services/failure.dart';

class CustomerOldOrdersRepoImpl implements CustomerOldOrdersRepo {
  final DataService _dataService;

  CustomerOldOrdersRepoImpl(this._dataService);

  @override
  Future<Either<Failure, PaginationResponse<CustomerTripDataResponse>>>
      getCustomerOldOrders({required int page}) async {
    return await _dataService
        .getData<PaginationResponse<CustomerTripDataResponse>>(
      endPoint: EndPoints.getCustomerTrips,
      queryParameters: {'page': page},
      fromJson: BaseMapResponse<PaginationResponse<CustomerTripDataResponse>>
          .fromJson,
      fromJsonData: (json) =>
          PaginationResponse<CustomerTripDataResponse>.fromJson(
        json as Map<String, dynamic>,
        (json) =>
            CustomerTripDataResponse.fromJson(json as Map<String, dynamic>),
      ),
    );
  }
}
