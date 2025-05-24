import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

class ThanksForRatting extends StatelessWidget {
  const ThanksForRatting({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            width: 313.w,
            height: 313.h,
            padding: EdgeInsets.only(top: 48.h, bottom: 47.h),
            decoration:
                const BoxDecoration(color: ColorManger.white, shape: BoxShape.circle),
            child: Column(
              children: [
                SvgPicture.asset(IconsAssets.thanksForRatting),
                20.51.verticalSpace,
                CustomText(
                    text: el.tr(AppStrings.thanksYouForRatting),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 20.sp))
              ],
            ),
          ),
        ],
      ),
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    );
  }
}
