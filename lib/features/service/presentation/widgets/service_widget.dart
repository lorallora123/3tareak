import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

class ServiceWidget extends StatelessWidget {
  final String title;
  final String image;
  final void Function()? onTap;

  const ServiceWidget({
    required this.title,
    required this.image,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300.w,
        height: 241.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          boxShadow: getBoxShadow(),
        ),
        child: Column(
          children: [
            44.verticalSpace,
            SvgPicture.asset(width: 157.w, height: 97.h, image),
            22.verticalSpace,
            CustomText(
              text: title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
