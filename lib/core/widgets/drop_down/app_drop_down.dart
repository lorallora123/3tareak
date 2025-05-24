import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:take_me_with_you/core/models/drop_down_model.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/core/widgets/drop_down/expand_widget.dart';

// ignore: must_be_immutable
class AppDropDown extends StatefulWidget {
  final String? title;
  final String? icon;
  final List<DropDownModel> items;
  String groupValue;
  String groupValueTitle;
  void Function(String?, String)? onChanged;
  final bool? disableOpen;

  AppDropDown(
      {this.title,
      this.icon,
      required this.items,
      required this.groupValue,
      required this.groupValueTitle,
      this.onChanged,
      this.disableOpen = false,
      super.key});

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  bool isExpand = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 400));
    animation = Tween<double>(begin: 0, end: pi).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 14.w, left: 10.w),
          child: GestureDetector(
            // splashColor: Colors.transparent,
            // overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: widget.disableOpen!
                ? null
                : () {
                    setState(() {
                      if (isExpand) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                      isExpand = !isExpand;
                    });
                  },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: Row(
                children: [
                  widget.icon != null
                      ? SvgPicture.asset(widget.icon!)
                      : const SizedBox.shrink(),
                  12.horizontalSpace,
                  widget.title != null
                      ? CustomText(
                          text: widget.title!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp))
                      : const SizedBox.shrink(),
                  (widget.icon == null && widget.title == null)
                      ? const SizedBox.shrink()
                      : const Spacer(),
                  if (widget.groupValue.isEmpty)
                    AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) => Transform.rotate(
                        angle: animation.value,
                        child: const Icon(
                          Icons.expand_more,
                        ),
                      ),
                    )
                  else
                    CustomText(
                        text: widget.groupValueTitle,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 15.sp))
                ],
              ),
            ),
          ),
        ),
        15.verticalSpace,
        const Divider(color: ColorManger.borderGreyColor),
        AnimatedCrossFade(
            firstChild: Container(
              margin: EdgeInsets.only(
                  top: 5.h, bottom: 5.h, right: 14.w, left: 12.w),
              decoration: BoxDecoration(
                  color: ColorManger.white,
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  border: Border.all(color: ColorManger.borderGreyColor)),
              child: isExpand
                  ? ExpandWidget(
                      items: widget.items,
                      groupValueTitle: widget.groupValueTitle,
                      groupValue: widget.groupValue,
                      onChanged: (v, a) {
                        if (widget.onChanged != null) {
                          widget.onChanged!(v, a);
                        }
                        setState(() {
                          if (isExpand) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                          isExpand = !isExpand;
                        });
                      })
                  : const SizedBox.shrink(),
            ),
            secondChild: const SizedBox.shrink(),
            firstCurve: Curves.linear,
            secondCurve: Curves.linear,
            reverseDuration: const Duration(milliseconds: 250),
            crossFadeState:
                isExpand ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500)),
      ],
    );
  }
}
