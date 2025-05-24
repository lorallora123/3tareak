import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/function.dart';

class VerticalSwipeButtonController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final RxDouble _position = 0.0.obs;
  final RxBool _isAnimating = false.obs;
  final Rx<SwipeButtonStatus> _status = SwipeButtonStatus.normal.obs;

  double get position => _position.value;

  bool get isAnimating => _isAnimating.value;

  SwipeButtonStatus get status => _status.value;

  set position(value) => _position.value = value;

  set isAnimating(value) => _isAnimating.value = value;

  set status(value) => _status.value = value;

  onVerticalDragStart(_) {
    isAnimating = true;
  }

  onVerticalDragUpdate(details) {
    position += details.delta.dy / Get.height;
  }

  loading() {
    status = SwipeButtonStatus.loading;
  }

  success() async {
    status = SwipeButtonStatus.success;
    await Future.delayed(const Duration(seconds: 3));
    status = SwipeButtonStatus.normal;
  }

  failure() async {
    status = SwipeButtonStatus.failure;
    await Future.delayed(const Duration(seconds: 3));
    status = SwipeButtonStatus.normal;
  }

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(
        milliseconds: 500,
      ),
      vsync: this,
    );

    animation = Tween<double>(begin: 0.0, end: -1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animation.addListener(() {
      position = animation.value;
    });
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

// ignore: must_be_immutable
class VerticalSwipeButton extends StatelessWidget {
  late VerticalSwipeButtonController controller;
  final void Function() onAnimationEnd;

  VerticalSwipeButton({required this.onAnimationEnd, super.key}) {
    controller = Get.put(VerticalSwipeButtonController(), tag: "100");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: controller.onVerticalDragStart,
      onVerticalDragUpdate: controller.onVerticalDragUpdate,
      onVerticalDragEnd: (_) async {
        controller.isAnimating = false;
        if (controller.position < -0.5) {
          controller.animationController
              .forward(from: controller.position)
              .then((value) async {
            controller.animationController.reverse(from: controller.position);
            onAnimationEnd();
          });
        } else {
          controller.animationController.reverse(from: controller.position);
        }
      },
      child: AnimatedBuilder(
        animation: controller.animationController,
        builder: (context, child) => Obx(
          () => Transform.translate(
            offset: Offset(
              0.0,
              (controller.isAnimating
                      ? controller.position
                      : controller.animation.value) *
                  500,
            ),
            child: child,
          ),
        ),
        child: Obx(
          () => AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            firstChild: SvgPicture.asset(IconsAssets.finishTripButton,
                fit: BoxFit.cover, width: 115.w, height: 115.h),
            reverseDuration: const Duration(milliseconds: 250),
            firstCurve: Curves.linear,
            secondCurve: Curves.linear,
            secondChild: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.status == SwipeButtonStatus.loading
                      ? ColorManger.primary
                      : controller.status == SwipeButtonStatus.success
                          ? Colors.green
                          : Colors.red),
              child: Center(
                child: SizedBox(
                  width: 70.w,
                  height: 70.h,
                  child: controller.status == SwipeButtonStatus.loading
                      ? const CircularProgressIndicator(
                          color: ColorManger.white,
                          strokeWidth: 5,
                        )
                      : controller.status == SwipeButtonStatus.success
                          ? Icon(
                              Icons.check,
                              color: ColorManger.white,
                              size: 50.w,
                            )
                          : Icon(
                              Icons.close,
                              color: ColorManger.white,
                              size: 50.w,
                            ),
                ),
              ),
            ),
            crossFadeState: controller.status == SwipeButtonStatus.normal
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
      ),
    );
  }
}
