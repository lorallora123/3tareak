import 'dart:io';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/styles_manger.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/app_text_filed.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/profile/controllers/edit_profile_controller.dart';
import 'package:take_me_with_you/core/utils/function.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  String _buildImageUrl(String imagePath) {
    if (imagePath.isEmpty || imagePath == 'null') {
      return '';
    }

    // Remove any leading slashes and encode the URL properly
    String cleanPath =
        imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    return 'https://3tre2k.nashwati.com/storage/app/public/$cleanPath';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          el.tr('تعديل ملفك الشخصي'),
          style: getBoldStyle(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.primary,
      ),
      backgroundColor: const Color.fromARGB(255, 210, 208, 208),
      body: Center(
        child: Container(
          width: 0.95.sw,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Form(
            key: controller.editformKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CustomText(
                      text: 'تعديل الملف الشخصي',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Changes indicator
                  Obx(() => controller.hasChanges
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: ColorManager.primary.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: ColorManager.primary,
                                size: 16.w,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'تم إجراء تغييرات',
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink()),

                  // Profile Image Section
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(() => Container(
                              width: 120.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorManager.primary,
                                  width: 3.w,
                                ),
                              ),
                              child: ClipOval(
                                child: controller.selectedImage.value != null
                                    ? Image.file(
                                        controller.selectedImage.value!,
                                        fit: BoxFit.cover,
                                      )
                                    : controller
                                            .currentImageUrl.value.isNotEmpty
                                        ? Image.network(
                                            _buildImageUrl(controller
                                                .currentImageUrl.value),
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey[300],
                                                child: Icon(
                                                  Icons.person,
                                                  size: 60.w,
                                                  color: Colors.grey[600],
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            color: Colors.grey[300],
                                            child: Icon(
                                              Icons.person,
                                              size: 60.w,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                              ),
                            )),
                        GestureDetector(
                          onTap: controller.isImageLoading.value
                              ? null
                              : controller.pickImage,
                          child: Container(
                            width: 35.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Obx(() => controller.isImageLoading.value
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Icon(
                                    Icons.camera_alt,
                                    size: 20.w,
                                    color: Colors.white,
                                  )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Remove image button if image is selected
                  Obx(() => controller.selectedImage.value != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextButton.icon(
                            onPressed: controller.removeSelectedImage,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 18.w,
                            ),
                            label: Text(
                              'إزالة الصورة',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink()),

                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(text: 'الاسم'),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: AppTextFiled(
                          controller: controller.nameController,
                          textAlign: TextAlign.right,
                          onChanged: (value) => controller.update(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(text: 'رقم الهاتف'),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: AppTextFiled(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.right,
                          onChanged: (value) => controller.update(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Obx(() => CheckboxListTile(
                        activeColor: ColorManager.primary,
                        value: controller.changePassword.value,
                        onChanged: (val) {
                          controller.changePassword.value = val!;
                          controller.update();
                        },
                        title: const CustomText(text: 'تغيير كلمة المرور'),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      )),
                  Obx(() => controller.changePassword.value
                      ? Column(
                          children: [
                            AppTextFiled(
                              controller: controller.currentPasswordController,
                              label: 'كلمة المرور الحالية',
                              isPassword:
                                  controller.isCurrentPasswordObscure.value,
                              suffixIcon:
                                  controller.isCurrentPasswordObscure.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                              onSuffixIcon: () => controller
                                      .isCurrentPasswordObscure.value =
                                  !controller.isCurrentPasswordObscure.value,
                              onChanged: (value) => controller.update(),
                            ),
                            SizedBox(height: 16.h),
                            AppTextFiled(
                              controller: controller.newPasswordController,
                              label: 'كلمة المرور الجديدة',
                              isPassword: controller.isNewPasswordObscure.value,
                              suffixIcon: controller.isNewPasswordObscure.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              onSuffixIcon: () =>
                                  controller.isNewPasswordObscure.value =
                                      !controller.isNewPasswordObscure.value,
                              onChanged: (value) => controller.update(),
                            ),
                            SizedBox(height: 16.h),
                            AppTextFiled(
                              controller: controller.confirmPasswordController,
                              label: 'تأكيد كلمة المرور الجديدة',
                              isPassword:
                                  controller.isConfirmPasswordObscure.value,
                              suffixIcon:
                                  controller.isConfirmPasswordObscure.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                              onSuffixIcon: () => controller
                                      .isConfirmPasswordObscure.value =
                                  !controller.isConfirmPasswordObscure.value,
                              onChanged: (value) => controller.update(),
                            ),
                          ],
                        )
                      : const SizedBox.shrink()),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'إلغاء',
                          color: Colors.grey[300],
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                          onTap: () => Get.back(),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Obx(() => AppButton(
                              text: controller.isLoading.value
                                  ? 'جاري الحفظ...'
                                  : 'حفظ',
                              color: ColorManager.primary,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                              onTap: controller.isLoading.value
                                  ? null
                                  : controller.onSave,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
