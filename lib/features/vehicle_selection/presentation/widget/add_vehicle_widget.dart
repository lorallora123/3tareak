import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class AddVehicleWidget extends StatelessWidget {
  const AddVehicleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 243.w,
      height: 92.h,
      decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
                color: ColorManager.black.withOpacity(0.12), blurRadius: 16)
          ],
          borderRadius: BorderRadius.circular(AppSize.s30)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 90.w,
            bottom: 60.h,
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.addVehicleRoute),
              child: Container(
                width: 64.w,
                height: 64.h,
                decoration: const BoxDecoration(
                    color: ColorManager.circleGreyColor,
                    shape: BoxShape.circle),
                child: Center(
                  child: Icon(Icons.add,
                      color: ColorManager.addButtonColor, size: 35.w),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 18.0.h),
              child: CustomText(
                  text: el.tr(AppStrings.addVehicle),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            ),
          )
        ],
      ),
    );
  }
}
