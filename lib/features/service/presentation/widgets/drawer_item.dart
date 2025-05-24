import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

class DrawerItem extends StatefulWidget {
  final String icon;
  final String title;
  final List<String>? children;
  final List<void Function()?>? onTapChildren;
  final void Function()? onTap;

  const DrawerItem(
      {required this.title,
      required this.icon,
      this.children,
      this.onTapChildren,
      this.onTap,
      super.key});

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap ??
              () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
          child: Container(
            margin: EdgeInsets.only(
                bottom: widget.children == null
                    ? 16.h
                    : isOpen
                        ? 0
                        : 16.h),
            padding: EdgeInsets.only(right: 48.w),
            width: 183.w,
            height: 42.h,
            decoration: BoxDecoration(
                color: ColorManger.primary.withOpacity(0.09),
                borderRadius: BorderRadius.circular(AppSize.s7)),
            child: Row(
              children: [
                SvgPicture.asset(widget.icon),
                7.horizontalSpace,
                CustomText(
                    text: widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15.sp))
              ],
            ),
          ),
        ),
        if (widget.children != null)
          AnimatedCrossFade(
              firstChild: const SizedBox(),
              secondChild: Container(
                padding: EdgeInsets.only(
                    bottom: 20.h, top: 20.h, left: 15.w, right: 15.w),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: widget.onTapChildren != null
                            ? widget.onTapChildren![i]
                            : () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: const BoxDecoration(
                                  color: ColorManger.primary,
                                  shape: BoxShape.circle),
                            ),
                            7.horizontalSpace,
                            CustomText(
                              text: widget.children![i],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 13.sp),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(
                      height: 20.h,
                    ),
                    itemCount: widget.children!.length,
                  ),
                ),
              ),
              firstCurve: Curves.linear,
              secondCurve: Curves.linear,
              crossFadeState:
                  isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250))
      ],
    );
  }
}
