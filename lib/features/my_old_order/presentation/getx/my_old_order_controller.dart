import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:take_me_with_you/core/models/base_response.dart';
import 'package:take_me_with_you/core/models/customer_trips_response.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/features/my_old_order/data/repo/customer_old_orders_repo.dart';

class MyOldOrdersController extends GetxController {
  final CustomerOldOrdersRepo _customerOldOrdersRepo =
      instance<CustomerOldOrdersRepo>();
  int pageNumber = 1;

  List<CustomerTripDataResponse> customerTripModel = [];
  PaginationResponse paginationEntity = PaginationResponse();

  final Rx<Failure> failure = Failure.Default().obs;

  RefreshController refreshController = RefreshController();

  final RxBool _loading = false.obs;

  bool get loading => _loading.value;

  set loading(value) => _loading.value = value;

  customerOldOrders({required int page}) async {
    loading = true;
    (await _customerOldOrdersRepo.getCustomerOldOrders(page: pageNumber))
        .fold((l) {}, (PaginationResponse r) async {
      paginationEntity = r;
      for (var element in paginationEntity.data!) {
        customerTripModel.add(element as CustomerTripDataResponse);
      }
    });
    loading = false;
  }

  onLoading() async {
    loading = true;
    loading = false;
    refreshController.loadComplete();
  }

  onRefresh() async {
    loading = true;
    await customerOldOrders(page: 1);

    refreshController.loadComplete();
  }

  onCustomRefresh() async {
    loading = true;
    await customerOldOrders(page: 1);

    refreshController.loadComplete();
  }

  @override
  void onInit() async {
    await customerOldOrders(page: 1);
    super.onInit();
  }
}
