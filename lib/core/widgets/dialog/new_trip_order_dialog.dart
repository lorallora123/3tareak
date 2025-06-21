import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/core/widgets/from_to_widget.dart';

class NewTripOrderDialog extends StatelessWidget {
  const NewTripOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            width: 351.w,
            padding: EdgeInsets.only(
                top: 18.h, left: 25.w, right: 25.w, bottom: 41.h),
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s30)),
            child: Column(
              children: [
                CustomText(
                    text: el.tr(AppStrings.newOrder),
                    style: Theme.of(context).textTheme.titleLarge!),
                27.verticalSpace,
                Container(
                  width: 291.w,
                  height: 118.h,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(AppSize.s7)),
                ),
                23.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                  child: const FromToWidget(
                      from: "قدسيا , نزلة الأحداث", to: "دمشق , جسر الرئيس"),
                ),
                22.verticalSpace,
                Divider(
                  color: ColorManager.borderGreyColor,
                  indent: 5.w,
                  endIndent: 6.w,
                ),
                21.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconsAssets.seats,
                        width: 14.w,
                        height: 21.h,
                      ),
                      12.horizontalSpace,
                      CustomText(
                          text: el.tr(AppStrings.theNumberOfSeatsRequired),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp)),
                      const Spacer(),
                      CustomText(
                          text: el.tr(AppStrings.all),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 15.sp)),
                    ],
                  ),
                ),
                25.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconsAssets.distance,
                        width: 20.53113555908203.w,
                        height: 23.h,
                      ),
                      12.horizontalSpace,
                      CustomText(
                          text: el.tr(AppStrings.distance),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp)),
                      const Spacer(),
                      CustomText(
                          text: "500 m",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 15.sp)),
                    ],
                  ),
                ),
                26.verticalSpace,
                Container(
                  width: 301.w,
                  height: 107.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.58.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: ColorManager.blueColor.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(AppSize.s7)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            IconsAssets.price,
                            // ignore: deprecated_member_use
                            color: ColorManager.blueColor,
                            width: 21.297443389892578.w,
                            height: 14.868025779724121.h,
                          ),
                          7.horizontalSpace,
                          CustomText(
                              text:
                                  el.tr(AppStrings.theAmountEarnedFromTheOrder),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 15.sp))
                        ],
                      ),
                      23.verticalSpace,
                      CustomText(
                          text: "10000 ل.س",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: ColorManager.blueColor))
                    ],
                  ),
                )
              ],
            ),
          ),
          9.verticalSpace,
          Container(
            width: 351.w,
            height: 99.h,
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton(
                  text: el.tr(AppStrings.accept),
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 20.sp, color: ColorManager.white),
                  onTap: () => Get.back(),
                  color: ColorManager.primary,
                  borderRadios: AppSize.s7,
                  width: 126.w,
                  height: 51.h,
                ),
                AppButton(
                  text: el.tr(AppStrings.reject),
                  textStyle: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 20.sp),
                  onTap: () => Get.back(),
                  color: ColorManager.primary.withOpacity(0.09),
                  borderRadios: AppSize.s7,
                  width: 126.w,
                  height: 51.h,
                ),
              ],
            ),
          )
        ],
      ),
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    );
  }
}
