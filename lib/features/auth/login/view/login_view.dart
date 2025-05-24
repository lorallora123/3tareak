import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/app_text_filed.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/auth/login/getx/login_controller.dart';
 
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  30.verticalSpace,
                  SvgPicture.asset(IconsAssets.logo,
                      width: 75.w, height: 75.h, fit: BoxFit.cover),
                  42.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      5.horizontalSpace,
                      CustomText(
                          text: el.tr(AppStrings.login),
                          style: Theme.of(context).textTheme.titleLarge!),
                    ],
                  ),
                  61.verticalSpace,
                  AppTextFiled(
                    prefixIcon: Icons.call,
                    label: el.tr(AppStrings.mobileNumber),
                    keyboardType: TextInputType.number,
                    action: TextInputAction.next,
                    controller: controller.phoneNumberController,
                    validator: validPhoneNumber,
                  ),
                  40.verticalSpace,
                  Obx(
                    () => AppTextFiled(
                      prefixIcon: Icons.lock,
                      label: el.tr(AppStrings.password),
                      suffixIcon: controller.isPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      isPassword: controller.isPassword,
                      onSuffixIcon: controller.onTapSuffixIcon,
                      controller: controller.passwordController,
                      validator: validPassword,
                    ),
                  ),
                  13.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                          text: el.tr(AppStrings.didYouForgetPassword),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 13.sp))
                    ],
                  ),
                  77.verticalSpace,
                  Obx(
                    () => controller.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : AppButton(
                            text: el.tr(AppStrings.login),
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: ColorManger.white),
                            onTap: controller.login,
                            color: ColorManger.blackText,
                            borderRadios: AppSize.s30,
                            width: 346.w,
                            height: 53.h,
                          ),
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "${el.tr(AppStrings.doNotHaveAnAccount)} ?",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15.sp)),
                      5.horizontalSpace,
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.registerRoute),
                        child: CustomText(
                            text: el.tr(AppStrings.signUp),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontSize: 15.sp,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManger.primary)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
