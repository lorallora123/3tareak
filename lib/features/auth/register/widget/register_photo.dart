import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/auth/register/getx/register_controller.dart';

class RegisterPhoto extends GetView<RegisterController> {
  const RegisterPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            60.verticalSpace,
            Center(
              child: SvgPicture.asset(
                IconsAssets.logo,
                width: 75.w,
                height: 75.h,
                fit: BoxFit.cover,
              ),
            ),
            60.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.w),
              child: CustomText(
                  text: el.tr(AppStrings.addPersonalImage),
                  style: Theme.of(context).textTheme.titleLarge!),
            ),
            11.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: CustomText(
                  text: el.tr(AppStrings.makeYourImageClear),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
            ),
            89.verticalSpace,
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(
                    () => Container(
                      width: 241.w,
                      height: 241.h,
                      decoration: BoxDecoration(
                          boxShadow: getBoxShadow(),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(controller.image)),
                          color: ColorManger.white,
                          shape: BoxShape.circle),
                      child: controller.image.path.isEmpty
                          ? Center(
                              child: Icon(
                                Icons.person,
                                size: 175.w,
                                color: ColorManger.iconLightGreyColor,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.onPickedImage,
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                          color: ColorManger.primary, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 34.w,
                          color: ColorManger.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => controller.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AppButton(
                      text: el.tr(AppStrings.next),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ColorManger.white),
                      onTap: controller.registerUser,
                      color: ColorManger.blackText,
                      borderRadios: AppSize.s30,
                      width: 346.w,
                      height: 53.h,
                    ),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
