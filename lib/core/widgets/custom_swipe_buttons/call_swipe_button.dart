import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

import 'package:url_launcher/url_launcher.dart';

class CallSwipeButton extends StatefulWidget {
  final bool isCaptain;
  final String? phone;

  const CallSwipeButton({super.key, this.phone, required this.isCaptain});

  @override
  State<CallSwipeButton> createState() => _CallSwipeButtonState();
}

class _CallSwipeButtonState extends State<CallSwipeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  bool _isAnimating = false;
  double _position = 0.0;
  Color? color = ColorManager.primary;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 250),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    ));
    _animation.addListener(() {
      _position = _animation.value;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onHorizontalDragStart(_) {
    _isAnimating = true;
  }

  onHorizontalDragUpdate(details) {
    setState(() {
      _position += details.delta.dx / Get.width;
      color = Colors.green;
    });
  }

  onHorizontalDragEnd(_) async {
    _isAnimating = false;
    if (_position > 0.5) {
      _controller.forward(from: _position).then((value) async {
        final Uri uri = Uri(
          scheme: 'tel',
          path: widget.phone.toString(),
        );
        await launchUrl(uri);
        _controller.reverse(from: _position);
      });
    } else {
      _controller.reverse(from: _position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.translate(
          offset: Offset(
            (_isAnimating ? _position : _animation.value) * 50,
            0.0,
          ),
          child: child,
        ),
        child: Container(
          width: 199.w,
          height: 38.h,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(AppSize.s30),
                bottomRight: Radius.circular(AppSize.s30),
              )),
          child: Row(
            children: [
              10.89.horizontalSpace,
              Icon(
                Icons.call,
                color: ColorManager.white,
                size: 23.w,
              ),
              8.horizontalSpace,
              CustomText(
                  text: widget.isCaptain
                      ? el.tr(AppStrings.scrollToContactTheCustomer)
                      : el.tr(AppStrings.scrollToContactTheCaptain),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 13.sp))
            ],
          ),
        ),
      ),
    );
  }
}
