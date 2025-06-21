import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/extensions.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

class StatusWidget extends StatelessWidget {
  final TripDataResponse model;

  const StatusWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -28.h,
      left: 11.w,
      child: Container(
        height: 46.h,
        padding:
            EdgeInsets.only(top: 1.h, bottom: 21.h, left: 13.w, right: 13.w),
        decoration: BoxDecoration(
            color: model.status == "pending"
                ? ColorManager.blueColor
                : ColorManager.primary,
            borderRadius: BorderRadius.circular(AppSize.s7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                text: model.status.toString().orEmpty().tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15.sp)),
          ],
        ),
      ),
    );
  }
}
