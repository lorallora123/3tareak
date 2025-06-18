import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_image.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/service/presentation/getx/service_controller.dart';

class PersonalInfo extends GetView<ServiceController> {
  final DrawerType drawerType;
  final AppPreferences appPreferences = instance<AppPreferences>();
  PersonalInfo({required this.drawerType, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 183.w,
          padding: EdgeInsets.only(bottom: 12.h, top: 27.h),
          decoration: BoxDecoration(
              color: ColorManger.primary.withOpacity(0.09),
              borderRadius: BorderRadius.circular(AppSize.s7)),
          child: Column(
            children: [
              // if (drawerType != DrawerType.normal) ...[
              //   CustomRating(
              //       rate: drawerType == DrawerType.captain
              //           ? controller.userDataModel.user!.rateAsCaptain.toDouble()
              //           : controller.userDataModel.user!.rateAsCustomer.toDouble(),
              //       readOnly: true,
              //       itemSize: 22.w),
              //   3.verticalSpace,
              //   CustomText(
              //       text:
              //           "${drawerType == DrawerType.captain ? controller.userDataModel.user!.rateAsCaptain.toDouble() : controller.userDataModel.user!.rateAsCustomer.toDouble()}",
              //       style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15.sp))
              // ],
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  10.horizontalSpace,
                  Icon(
                    Icons.person,
                    size: 18.w,
                    color: ColorManger.primary,
                  ),
                  8.horizontalSpace,
                  CustomText(
                      text: appPreferences.getUserName().toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15.sp))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  10.horizontalSpace,
                  Icon(
                    Icons.call,
                    size: 18.w,
                    color: ColorManger.primary,
                  ),
                  9.horizontalSpace,
                  CustomText(
                      text: appPreferences.getUserPhoneNumber().toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15.sp))
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 46.w,
          bottom: drawerType != DrawerType.normal ? 130.h : 80.h,
          child: Container(
            width: 88.w,
            height: 88.h,
            decoration: BoxDecoration(
                color: ColorManger.primary.withOpacity(0.5),
                shape: BoxShape.circle,
                border: Border.all(
                    color: ColorManger.white,
                    width: 5,
                    style: BorderStyle.solid)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s100),
                child: AppImage(
                  imageUrl: controller.userDataModel.user?.image != null &&
                          controller.userDataModel.user!.image!.isNotEmpty
                      ? 'https://3tre2k.nashwati.com/${controller.userDataModel.user!.image!}'
                      : '',
                  boxFit: BoxFit.cover,
                )),
          ),
        ),
      ],
    );
  }
}
