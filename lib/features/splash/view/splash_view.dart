import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/features/splash/getx/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            PositionedDirectional(
              bottom: 0,
              child: SvgPicture.asset(
                ImageAssets.SPLASH,
                fit: BoxFit.fill,
                width: Get.width,
              ),
            ),
            Positioned(
              top: 50.h,
              child: FadeTransition(
                opacity: controller.fadingAnimation!,
                child: SvgPicture.asset(
                  ImageAssets.APP_LOGO,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
