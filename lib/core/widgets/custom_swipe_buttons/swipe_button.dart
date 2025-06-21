import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

class SwipeButtonController extends GetxController
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

  onHorizontalDragStart(_) {
    isAnimating = true;
  }

  onHorizontalDragUpdate(details) {
    position += details.delta.dx / Get.width;
  }

  loading() {
    status = SwipeButtonStatus.loading;
  }

  success() async {
    status = SwipeButtonStatus.success;
    await Future.delayed(const Duration(seconds: 3));
    status = SwipeButtonStatus.normal;
    animationController.reverse(from: position);
  }

  failure() async {
    status = SwipeButtonStatus.failure;
    await Future.delayed(const Duration(seconds: 3));
    status = SwipeButtonStatus.normal;
    animationController.reverse(from: position);
  }

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
class SwipeButton extends StatelessWidget {
  final String text;
  final bool? isPrimary;
  final void Function() onAnimationEnd;
  late SwipeButtonController controller;
  final int index;

  SwipeButton({
    required this.text,
    this.isPrimary = false,
    required this.onAnimationEnd,
    required this.index,
    Key? key,
  }) : super(key: key) {
    controller = Get.put(SwipeButtonController(), tag: "$index");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onHorizontalDragStart: controller.onHorizontalDragStart,
          onHorizontalDragUpdate: controller.onHorizontalDragUpdate,
          onHorizontalDragEnd: (_) async {
            controller.isAnimating = false;
            if (controller.position > 0.5) {
              controller.animationController
                  .forward(from: controller.position)
                  .then((value) async {
                onAnimationEnd();
              });
            } else {
              controller.animationController.reverse(from: controller.position);
            }
          },
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: controller.status == SwipeButtonStatus.normal
                      ? 300.w
                      : 40.w,
                  height: controller.status == SwipeButtonStatus.normal
                      ? 28.h
                      : 40.h,
                  decoration: BoxDecoration(
                      color: controller.status == SwipeButtonStatus.normal ||
                              controller.status == SwipeButtonStatus.loading
                          ? isPrimary!
                              ? ColorManager.primary.withOpacity(0.09)
                              : ColorManager.blueColor.withOpacity(0.09)
                          : controller.status == SwipeButtonStatus.success
                              ? Colors.green
                              : Colors.red,
                      borderRadius: BorderRadius.circular(AppSize.s30)),
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 250),
                    crossFadeState:
                        controller.status == SwipeButtonStatus.loading
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    firstChild: Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                            color: isPrimary!
                                ? ColorManager.primary
                                : ColorManager.blueColor),
                      ),
                    ),
                    reverseDuration: const Duration(milliseconds: 250),
                    firstCurve: Curves.linear,
                    secondCurve: Curves.linear,
                    secondChild: Center(
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 250),
                        crossFadeState:
                            controller.status == SwipeButtonStatus.success
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                        firstChild: Icon(Icons.check,
                            color: ColorManager.white, size: 35.w),
                        reverseDuration: const Duration(milliseconds: 250),
                        firstCurve: Curves.linear,
                        secondCurve: Curves.linear,
                        secondChild:
                            controller.status == SwipeButtonStatus.failure
                                ? Icon(Icons.close,
                                    color: ColorManager.white, size: 35.w)
                                : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.status == SwipeButtonStatus.normal,
                  child: AnimatedBuilder(
                    animation: controller.animationController,
                    builder: (context, child) => Obx(
                      () => Transform.translate(
                        offset: Offset(
                          (controller.isAnimating
                                  ? controller.position
                                  : controller.animation.value) *
                              200,
                          0.0,
                        ),
                        child: child,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          IconsAssets.startTripArrow,
                          // ignore: deprecated_member_use
                          color: isPrimary!
                              ? ColorManager.primary
                              : ColorManager.blueColor,
                          width: 36.w,
                          height: 7.5.h,
                        ),
                        SvgPicture.asset(
                          isPrimary!
                              ? IconsAssets.swipeButtonPrimary
                              : IconsAssets.swipeButton,
                          width: 59.w,
                          height: 59.h,
                        ),
                        15.horizontalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        5.verticalSpace,
        CustomText(
            text: text,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 12.sp)),
      ],
    );
  }
}
