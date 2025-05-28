import 'package:get/get.dart';
import 'package:take_me_with_you/features/spin/data/models/spin_request.dart';
import 'package:take_me_with_you/features/spin/data/repo/spin_repo.dart';
import 'package:take_me_with_you/imports.dart';

class SpinController extends GetxController {
  final SpinRepo _spinRepo = instance<SpinRepo>();

  RxBool _isLoading = false.obs;
  set isLoading(value) => _isLoading = value;
  get isLoading => _isLoading;

  Future<void> spin({
    required double rate,
  }) async {
    isLoading = false;
    (await _spinRepo.spin(SpinRequest(spin: rate, type: 'app'))).fold(
      (l) => AppMessage.showToast(l.message),
      (r) async => AppMessage.showToast(r.message!),
    );
  }
}
