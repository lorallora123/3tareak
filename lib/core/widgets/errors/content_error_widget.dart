import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/design_constants.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';

class ContentErrorWidget extends StatelessWidget {
  final String description;
  final Function onPress;
  final String buttonTitle;
  final int errorCode;
  final double? width;
  final double? height;

  const ContentErrorWidget(
      {Key? key,
      required this.description,
      required this.onPress,
      required this.buttonTitle,
      required this.errorCode,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 6.h, 22.w, 6.h),
      child: Container(
        width: width ?? 200,
        // height: height ?? 200,
        // padding: EdgeInsets.symmetric(horizontal: width ?? 200.w),
        decoration: BoxDecoration(
          color: ColorManger.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [lowElevation],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageAssets.error,
              // color: ColorManger.addButtonColor,
              height: 100,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Text(description,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge?.copyWith(
                          letterSpacing: 0.8, fontSize: width ?? 16.sp)),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            AppButton(
              text: "اعادة المحاولة",
              color: ColorManger.primary,
              textStyle: theme.textTheme.bodyMedium,
              onTap: () => onPress(),
              height: 40.h,
              width: 150.h,
              borderRadios: 100.r,
            ),
          ],
        ),
      ),
    );
  }
}
