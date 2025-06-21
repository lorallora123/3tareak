import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

import 'swipe_button.dart';

// ignore: must_be_immutable
class StartTripSwipeButton extends StatefulWidget {
  late SwipeButtonController controller;
  final void Function() onAnimationEnd;

  StartTripSwipeButton({required this.onAnimationEnd, super.key}) {
    controller = Get.put(SwipeButtonController(), tag: "99");
  }

  @override
  State<StartTripSwipeButton> createState() => _StartTripSwipeButtonState();
}

class _StartTripSwipeButtonState extends State<StartTripSwipeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: widget.controller.onHorizontalDragStart,
      onHorizontalDragUpdate: widget.controller.onHorizontalDragUpdate,
      onHorizontalDragEnd: (_) async {
        widget.controller.isAnimating = false;
        if (widget.controller.position > 0.5) {
          widget.controller.animationController
              .forward(from: widget.controller.position)
              .then((value) async {
            widget.onAnimationEnd();
            widget.controller.animationController
                .reverse(from: widget.controller.position);
          });
        } else {
          widget.controller.animationController
              .reverse(from: widget.controller.position);
        }
      },
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
              color: widget.controller.status == SwipeButtonStatus.normal ||
                      widget.controller.status == SwipeButtonStatus.loading
                  ? ColorManager.blueColor
                  : widget.controller.status == SwipeButtonStatus.success
                      ? Colors.green
                      : Colors.red,
              borderRadius: BorderRadius.circular(AppSize.s30)),
          width: widget.controller.status == SwipeButtonStatus.normal
              ? 351.w
              : 40.w,
          height: widget.controller.status == SwipeButtonStatus.normal
              ? 54.h
              : 40.h,
          child: AnimatedBuilder(
            animation: widget.controller.animationController,
            builder: (context, child) => Obx(
              () => Transform.translate(
                offset: Offset(
                  (widget.controller.isAnimating
                          ? widget.controller.position
                          : widget.controller.animation.value) *
                      100,
                  0.0,
                ),
                child: child,
              ),
            ),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState:
                  widget.controller.status == SwipeButtonStatus.loading
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              firstChild: Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                      color: ColorManager.white),
                ),
              ),
              reverseDuration: const Duration(milliseconds: 250),
              firstCurve: Curves.linear,
              secondCurve: Curves.linear,
              secondChild: Center(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 250),
                  crossFadeState:
                      widget.controller.status == SwipeButtonStatus.success
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                  firstChild:
                      Icon(Icons.check, color: ColorManager.white, size: 35.w),
                  reverseDuration: const Duration(milliseconds: 250),
                  firstCurve: Curves.linear,
                  secondCurve: Curves.linear,
                  secondChild: widget.controller.status ==
                          SwipeButtonStatus.failure
                      ? Icon(Icons.close, color: ColorManager.white, size: 35.w)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconsAssets.startTripArrow,
                                width: 29.w, height: 13.h),
                            8.horizontalSpace,
                            CustomText(
                                text: el.tr(AppStrings.swipeToStartTheTrip),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: ColorManager.white)),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
