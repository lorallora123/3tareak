import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/fcm_token_handler.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final String image = ImageAssets.splash;
  late AnimationController animationController;
  late Animation<double>? fadingAnimation;

  getNextPage() {
    if (_appPreferences.getOnBoarding() != null) {
      if (_appPreferences.getUserToken() != null) {
        Get.offAllNamed(AppRoutes.serviceRoute);
      } else {
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    } else {
      Get.offAllNamed(AppRoutes.onBoardingRoute);
    }
  }

  @override
  void onInit() {
    FcmTokenHandler.handleFcmToken();

    final userToken = _appPreferences.getUserToken();
    print('user uoken: $userToken');

    animation();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void animation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController);

    animationController.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 1), () {
      getNextPage();
    });
  }
}
