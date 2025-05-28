import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';

class DeliveredButton extends StatelessWidget {
  const DeliveredButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        AppButton(
          text: el.tr(AppStrings.deliveredSuccessfully),
          textStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 12.sp, color: ColorManger.white),
          onTap: () {},
          width: 300.w,
          height: 38.h,
          color: ColorManger.primary,
          borderRadios: AppSize.s30,
        ),
        Container(
          width: 59.w,
          height: 59.h,
          margin: EdgeInsets.only(right: 13.w),
          decoration: BoxDecoration(
              color: ColorManger.primary,
              shape: BoxShape.circle,
              border: Border.all(color: ColorManger.white, width: 3)),
          child: Center(
            child: Icon(
              Icons.check,
              color: ColorManger.white,
              size: 35.w,
            ),
          ),
        )
      ],
    );
  }
}
