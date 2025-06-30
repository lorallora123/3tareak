import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/features/profile/controllers/profile_controller.dart';
import 'package:take_me_with_you/features/profile/data/models/update_profile_request.dart';
import 'package:take_me_with_you/features/profile/data/repo/update_profile_repo.dart';

class EditProfileController extends GetxController {
  final UpdateProfileRepo _updateProfileRepo = instance<UpdateProfileRepo>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final editformKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxBool changePassword = false.obs;
  RxBool isCurrentPasswordObscure = true.obs;
  RxBool isNewPasswordObscure = true.obs;
  RxBool isConfirmPasswordObscure = true.obs;
  RxBool isLoading = false.obs;

  final ImagePicker picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString currentImageUrl = ''.obs;
  final RxBool isImageLoading = false.obs;

  String originalName = '';
  String originalPhone = '';
  String originalImageUrl = '';
  String? storedPassword;

  @override
  void onInit() {
    super.onInit();
    loadCurrentProfileData();
    loadStoredPassword();
  }

  void loadCurrentProfileData() {
    try {
      final profileController = Get.find<ProfileController>();
      originalName = profileController.fullname.value;
      originalPhone = profileController.phoneNumber.value;
      originalImageUrl = profileController.imageUrl.value;

      nameController.text = originalName;
      phoneController.text = originalPhone;
      currentImageUrl.value = originalImageUrl;
    } catch (e) {
      print('Error loading profile data: $e');
      nameController.text = '';
      phoneController.text = '';
      currentImageUrl.value = '';
    }
  }

  void loadStoredPassword() {
    storedPassword = _appPreferences.getUserPassword();
  }

  Future<void> pickImage() async {
    try {
      isImageLoading.value = true;
      final XFile? imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (imageFile != null && imageFile.path.isNotEmpty) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'قص الصورة',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
            IOSUiSettings(title: 'قص الصورة'),
          ],
        );

        if (croppedFile != null) {
          selectedImage.value = File(croppedFile.path);
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  void removeSelectedImage() {
    selectedImage.value = null;
  }

  bool get hasChanges {
    final nameChanged = nameController.text.trim() != originalName;
    final phoneChanged = phoneController.text.trim() != originalPhone;
    final imageChanged = selectedImage.value != null;
    final passwordChanged = changePassword.value &&
        (currentPasswordController.text.trim().isNotEmpty ||
            newPasswordController.text.trim().isNotEmpty ||
            confirmPasswordController.text.trim().isNotEmpty);

    return nameChanged || phoneChanged || imageChanged || passwordChanged;
  }

  bool validateCurrentPassword(String currentPassword) {
    if (storedPassword == null) {
      return false;
    }
    return currentPassword == storedPassword;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> onSave() async {
    if (!hasChanges) {
      AppMessage.showToast('لم يتم إجراء أي تغييرات');
      return;
    }

    String? validationError;

    if (nameController.text.trim() != originalName) {
      if (nameController.text.trim().isEmpty) {
        validationError = 'يرجى إدخال الاسم';
      }
    }

    if (phoneController.text.trim() != originalPhone) {
      if (phoneController.text.trim().isEmpty) {
        validationError = 'يرجى إدخال رقم الهاتف';
      } else if (validPhoneNumber(phoneController.text.trim()) != null) {
        validationError = 'يرجى إدخال رقم هاتف صحيح';
      }
    }

    if (changePassword.value) {
      if (currentPasswordController.text.trim().isEmpty) {
        validationError = 'يرجى إدخال كلمة المرور الحالية';
      } else if (!validateCurrentPassword(
          currentPasswordController.text.trim())) {
        validationError = 'كلمة المرور الحالية غير صحيحة';
      } else if (newPasswordController.text.trim().isEmpty) {
        validationError = 'يرجى إدخال كلمة المرور الجديدة';
      } else if (validPassword(newPasswordController.text.trim()) != null) {
        validationError = 'كلمة المرور الجديدة يجب أن تكون 8 أحرف على الأقل';
      } else if (confirmPasswordController.text.trim().isEmpty) {
        validationError = 'يرجى تأكيد كلمة المرور الجديدة';
      } else if (confirmPasswordController.text.trim() !=
          newPasswordController.text.trim()) {
        validationError = 'كلمة المرور غير متطابقة';
      }
    }

    if (validationError != null) {
      AppMessage.showToast(validationError);
      return;
    }

    try {
      isLoading.value = true;

      final updateRequest = UpdateProfileRequest(
        fullname: nameController.text.trim(),
        phoneNumber: phoneController.text.trim() != originalPhone
            ? phoneController.text.trim()
            : null,
        password:
            changePassword.value ? currentPasswordController.text.trim() : null,
        newPassword:
            changePassword.value ? newPasswordController.text.trim() : null,
        newPasswordConfirmation:
            changePassword.value ? confirmPasswordController.text.trim() : null,
        image: selectedImage.value,
      );

      print('Sending to API: ${await updateRequest.toJson()}');

      final result = await _updateProfileRepo.updateProfile(
        updateProfileRequest: updateRequest,
      );

      result.fold(
        (failure) {
          AppMessage.showToast(failure.message);
        },
        (success) async {
          AppMessage.showToast('تم تحديث الملف الشخصي بنجاح');

          try {
            final profileController = Get.find<ProfileController>();
            await profileController.fetchProfile();
          } catch (e) {
            print('Error updating profile controller: $e');
          }

          isLoading.value = false;
          Get.back();
        },
      );
    } catch (e) {
      AppMessage.showToast('حدث خطأ أثناء تحديث الملف الشخصي');
      print('Error in onSave: $e');
    }
  }
}
