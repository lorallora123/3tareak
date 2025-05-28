import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';
import 'package:flutter/material.dart';

class AddImageWidget extends GetView<AddVehicleController> {
  const AddImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.addVehicleImage,
      child: Container(
        height: 142.h,
        width: 152.w,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s14)),
        child: Stack(
          children: [
            Positioned(
              right: 55.w,
              top: 35.h,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorManger.greyColor),
                child: Center(
                  child:
                      Icon(Icons.add, color: ColorManger.primary, size: 30.w),
                ),
              ),
            ),
            Positioned(
              top: 85.h,
              right: 39.w,
              child: CustomText(
                  text: el.tr(AppStrings.addPicture),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            )
          ],
        ),
      ),
    );
  }
}
