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

  // Image picker functionality
  final ImagePicker picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString currentImageUrl = ''.obs;
  final RxBool isImageLoading = false.obs;

  // Store original values to track changes
  String originalName = '';
  String originalPhone = '';
  String originalImageUrl = '';
  String? storedPassword; // Store the password used to login

  @override
  void onInit() {
    super.onInit();
    loadCurrentProfileData();
    loadStoredPassword();
  }

  void loadCurrentProfileData() {
    // Get current profile data from ProfileController
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
      // Fallback to empty values if ProfileController is not available
      nameController.text = '';
      phoneController.text = '';
      currentImageUrl.value = '';
    }
  }

  void loadStoredPassword() {
    // Load the password that was used during login
    // This should be stored securely during login
    storedPassword =
        _appPreferences.getUserPassword(); // You'll need to implement this
  }

  Future<void> pickImage() async {
    try {
      isImageLoading.value = true;
      final XFile? imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (imageFile != null && imageFile.path.isNotEmpty) {
        // Crop the image
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

  // Check if any data has been modified
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

  // Validate current password against stored password
  bool validateCurrentPassword(String currentPassword) {
    if (storedPassword == null) {
      // If no stored password, we can't validate - this might happen if user logged in with token
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
    // Check if any changes were made
    if (!hasChanges) {
      AppMessage.showToast('لم يتم إجراء أي تغييرات');
      return;
    }

    // Validate only the fields that are being changed
    String? validationError;

    // Validate name if it's being changed
    if (nameController.text.trim() != originalName) {
      if (nameController.text.trim().isEmpty) {
        validationError = 'يرجى إدخال الاسم';
      }
    }

    // Validate phone if it's being changed
    if (phoneController.text.trim() != originalPhone) {
      if (phoneController.text.trim().isEmpty) {
        validationError = 'يرجى إدخال رقم الهاتف';
      } else if (validPhoneNumber(phoneController.text.trim()) != null) {
        validationError = 'يرجى إدخال رقم هاتف صحيح';
      }
    }

    // Validate password fields only if password change is requested
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

    // Show validation error if any
    if (validationError != null) {
      AppMessage.showToast(validationError);
      return;
    }

    try {
      isLoading.value = true;

      // Create update profile request with only the fields we want to send to server
      final updateRequest = UpdateProfileRequest(
        fullname: nameController.text.trim() != originalName
            ? nameController.text.trim()
            : null,
        phoneNumber: phoneController.text.trim() != originalPhone
            ? phoneController.text.trim()
            : null,
        newPassword:
            changePassword.value ? newPasswordController.text.trim() : null,
        image: selectedImage.value,
      );

      // Print the request for debugging
      print('Sending to API: ${await updateRequest.toJson()}');

      // Call the API
      final result = await _updateProfileRepo.updateProfile(
        updateProfileRequest: updateRequest,
      );

      result.fold(
        (failure) {
          AppMessage.showToast(failure.message);
        },
        (success) {
          AppMessage.showToast('تم تحديث الملف الشخصي بنجاح');

          // Update the profile controller with new data
          try {
            final profileController = Get.find<ProfileController>();

            // Update only the fields that were changed
            if (nameController.text.trim() != originalName) {
              profileController.fullname.value = nameController.text.trim();
            }
            if (phoneController.text.trim() != originalPhone) {
              profileController.phoneNumber.value = phoneController.text.trim();
            }

            // If image was updated, refresh the profile to get new image URL
            if (selectedImage.value != null) {
              profileController.fetchProfile();
            }
          } catch (e) {
            print('Error updating profile controller: $e');
          }

          // Navigate back to profile page
          Get.back();
        },
      );
    } catch (e) {
      AppMessage.showToast('حدث خطأ أثناء تحديث الملف الشخصي');
      print('Error in onSave: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
