import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class VehicleSelectionController extends GetxController {
  final VehicleSelectionRepo _vehicleSelectionRepo =
      instance<VehicleSelectionRepo>();
  final RxBool _loading = false.obs;
  final Rx<VehicleResponse> _vehicleModel = VehicleResponse([]).obs;
  late VehicleTypeResponse vehicleTypeModel;
  Rx<VehicleDataResponse> selectedVehicle = VehicleDataResponse().obs;

  bool get loading => _loading.value;

  VehicleResponse get vehicleModel => _vehicleModel.value;

  set loading(value) => _loading.value = value;

  set vehicleModel(value) => _vehicleModel.value = value;

  getCaptainVehicles() async {
    (await _vehicleSelectionRepo.getCaptainVehicles())
        .fold((l) => AppMessage.showToast(l.message), (r) => vehicleModel = r);
  }

  getVehicleType() async {
    (await _vehicleSelectionRepo.getVehicleTypes()).fold(
        (l) => AppMessage.showToast(l.message), (r) => vehicleTypeModel = r);
  }

  @override
  void onInit() async {
    loading = true;
    await getCaptainVehicles();
    await getVehicleType();
    loading = false;
    super.onInit();
  }
}
