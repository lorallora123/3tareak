import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class CreateVehicleDialog extends StatelessWidget {
  const CreateVehicleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            width: 313.w,
            height: 313.h,
            decoration: const BoxDecoration(
                color: ColorManager.white, shape: BoxShape.circle),
            child: Column(
              children: [
                49.verticalSpace,
                SvgPicture.asset(
                  IconsAssets.createVehicle,
                  width: 194.w,
                  height: 123.h,
                  fit: BoxFit.cover,
                ),
                28.verticalSpace,
                CustomText(
                    text: el.tr(AppStrings.createOrderSuccessMessage),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15.sp))
              ],
            ),
          ),
          18.verticalSpace,
          AppButton(
            text: el.tr(AppStrings.confirm),
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorManager.white),
            onTap: () => Get.back(),
            color: ColorManager.blackText,
            borderRadios: AppSize.s30,
            width: 253.w,
            height: 53.h,
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
