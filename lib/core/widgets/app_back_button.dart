import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton(
      {this.onTap, super.key, this.iconImage, this.iconHeight, this.iconWidth});

  final void Function()? onTap;
  final String? iconImage;
  final double? iconHeight;
  final double? iconWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.back(),
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: getBoxShadow()),
        child: Center(
          child: iconImage != null
              ? SvgPicture.asset(
                  iconImage!,
                  height: iconHeight ?? 20.h,
                  width: iconWidth ?? 20.w,
                )
              : Icon(Icons.arrow_back_ios_sharp,
                  size: Get.height * 0.025,
                  color: ColorManger.blackText,
                  weight: AppSize.s65),
        ),
      ),
    );
  }
}
