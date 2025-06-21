import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/features/auth/data/models/user_login_request.dart';
import 'package:take_me_with_you/features/auth/data/repo/auth_repo.dart';

class LoginController extends GetxController {
  final AuthRepo _authRepo = instance<AuthRepo>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final formKey = GlobalKey<FormState>();
  final RxBool _loading = false.obs;
  final _isPassword = true.obs;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isPassword => _isPassword.value;

  bool get loading => _loading.value;

  set isPassword(value) => _isPassword.value = value;

  set loading(value) => _loading.value = value;

  onTapSuffixIcon() {
    isPassword = !isPassword;
  }

  login() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      (await _authRepo.login(
              loginRequest: UserLoginRequest(
                  phoneNumberController.text, passwordController.text)))
          .fold(
              (l) => AppMessage.appSnackBar(el.tr(AppStrings.error), l.message),
              (r) async {
        await _appPreferences.setUserToken(
          r.token!,
          r.user?.fullName ?? '',
          r.user?.phoneNumber ?? '',
          r.user?.id ?? 0,
        );
        await _appPreferences.setUserPassword(passwordController.text);
        Get.offAllNamed(AppRoutes.serviceRoute);
      });
      loading = false;
    }
  }
}
