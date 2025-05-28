import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/font_manger.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_back_button.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/app_text_filed.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/auth/register/getx/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 1.sw,
          height: 1.sh,
          color: ColorManger.white,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            IconsAssets.lightRoadBackground,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  30.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AppBackButton(),
                      const Spacer(),
                      SvgPicture.asset(
                        IconsAssets.logo,
                        width: 75.w,
                        height: 76.h,
                        fit: BoxFit.cover,
                      ),
                      const Spacer(),
                    ],
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      5.horizontalSpace,
                      CustomText(
                          text: el.tr(AppStrings.signUp),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 20.sp)),
                    ],
                  ),
                  33.verticalSpace,
                  AppTextFiled(
                    label: el.tr(AppStrings.name),
                    prefixIcon: Icons.person,
                    action: TextInputAction.next,
                    controller: controller.nameController,
                    validator: valid,
                  ),
                  40.verticalSpace,
                  AppTextFiled(
                    prefixIcon: Icons.call,
                    label: el.tr(AppStrings.mobileNumber),
                    action: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: controller.mobileController,
                    validator: validPhoneNumber,
                  ),
                  40.verticalSpace,
                  Obx(
                    () => AppTextFiled(
                      prefixIcon: Icons.lock,
                      suffixIcon: controller.password
                          ? Icons.visibility_off
                          : Icons.visibility,
                      action: TextInputAction.next,
                      label: el.tr(AppStrings.password),
                      isPassword: controller.password,
                      controller: controller.passwordController,
                      onSuffixIcon: controller.onTapSuffixPassword,
                      validator: validPassword,
                    ),
                  ),
                  40.verticalSpace,
                  Obx(
                    () => AppTextFiled(
                      label: el.tr(AppStrings.confirmPassword),
                      prefixIcon: Icons.lock,
                      suffixIcon: controller.confirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      isPassword: controller.confirmPassword,
                      controller: controller.confirmPasswordController,
                      onSuffixIcon: controller.onTapSuffixConfirmPassword,
                      validator: (String? value) {
                        if (controller.validConfirmPassword(value)) {
                          return null;
                        } else {
                          return el.tr(AppStrings.validConfirmPassword);
                        }
                      },
                    ),
                  ),
                  40.verticalSpace,
                  AppButton(
                    text: el.tr(AppStrings.register),
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: FontSize.s20, color: ColorManger.white),
                    onTap: controller.onTapRegisterPage,
                    color: ColorManger.blackText,
                    borderRadios: AppSize.s30,
                    width: 346.w,
                    height: 53.h,
                  ),
                  66.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "${el.tr(AppStrings.haveAnAccount)} ?",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp)),
                      5.horizontalSpace,
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: CustomText(
                            text: el.tr(AppStrings.login),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontSize: 15.sp,
                                    decorationColor: ColorManger.primary,
                                    decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: el.tr(AppStrings.byContinuingYouAgreeTo),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 13.sp)),
                        TextSpan(
                            text: el.tr(
                                AppStrings.termsAndConditionsAndPrivacyPolicy),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontSize: 13.sp,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManger.primary)),
                      ])),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
