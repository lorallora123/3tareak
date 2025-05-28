import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';

import 'custom_text.dart';

class SeatsNumberContainer extends StatelessWidget {
  final Function onTap;
  final Color color;
  final int index;

  const SeatsNumberContainer(
      {Key? key, required this.onTap, required this.index, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 49.69117736816406.w,
        height: 49.69117736816406.h,
        decoration: BoxDecoration(
            color: ColorManger.white,
            boxShadow: getBoxShadow(),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(AppSize.s7)),
        child: Center(
          child: CustomText(
            text: "${index + 1}",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 15.sp, color: color),
          ),
        ),
      ),
    );
  }
}
