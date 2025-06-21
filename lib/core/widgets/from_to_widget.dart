import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';

import 'custom_text.dart';

class FromToWidget extends StatelessWidget {
  final String from;
  final Function? onTapFrom;
  final String to;
  final Function? onTapTo;
  final double? space;
  final bool select;

  const FromToWidget({
    required this.from,
    required this.to,
    super.key,
    this.space,
    this.select = false,
    this.onTapFrom,
    this.onTapTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              IconsAssets.fromToLocation,
              width: 24.w,
              height: space != null ? 87.h : 100.h,
            ),
            SvgPicture.asset(
              IconsAssets.threeDot,
              width: 3.w,
              height: space != null ? 18.h : 20.h,
            ),
          ],
        ),
        15.horizontalSpace,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTapFrom != null
                    ? () {
                        onTapFrom!();
                      }
                    : null,
                child: Row(
                  children: [
                    CustomText(
                        text: "${el.tr(AppStrings.from)} :",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 15.sp,
                                color: ColorManager.blueColor)),
                    14.horizontalSpace,
                    if (!select)
                      SizedBox(
                        width: 180.w,
                        child: CustomText(
                            text: from,
                            maxLine: 2,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 15.sp,
                                )),
                      ),
                    if (select) ...[
                      const Spacer(),
                      SizedBox(
                        width: 180.w,
                        child: CustomText(
                            text: from,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 15.sp,
                                    color: ColorManager.primary)),
                      ),
                    ]
                  ],
                ),
              ),
              space == null ? 20.verticalSpace : space!.verticalSpace,
              Divider(
                indent: 6.w,
                endIndent: 7.w,
                color: ColorManager.iconLightGreyColor,
              ),
              space == null ? 22.verticalSpace : space!.verticalSpace,
              GestureDetector(
                onTap: onTapTo != null
                    ? () {
                        onTapTo!();
                      }
                    : null,
                child: Row(
                  children: [
                    CustomText(
                        text: "${el.tr(AppStrings.to)} :",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 15.sp)),
                    14.horizontalSpace,
                    if (!select)
                      SizedBox(
                        width: 180.w,
                        child: CustomText(
                            text: to,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 15.sp,
                                )),
                      ),
                    if (select) ...[
                      const Spacer(),
                      SizedBox(
                        width: 180.w,
                        child: CustomText(
                            text: to,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 15.sp,
                                    color: ColorManager.primary)),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
