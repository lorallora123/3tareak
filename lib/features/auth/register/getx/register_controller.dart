import 'dart:io';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/features/auth/data/models/register_user_request.dart';
import 'package:take_me_with_you/features/auth/data/repo/auth_repo.dart';
import 'package:take_me_with_you/features/auth/register/widget/register_photo.dart';

class RegisterController extends GetxController {
  final AuthRepo _authRepo = instance<AuthRepo>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final formKey = GlobalKey<FormState>();
  final RxBool _password = true.obs;
  final RxBool _confirmPassword = true.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ImagePicker picker = ImagePicker();
  final Rx<File> _image = File('').obs;
  final RxBool _loading = false.obs;

  bool get password => _password.value;

  bool get confirmPassword => _confirmPassword.value;

  File get image => _image.value;

  bool get loading => _loading.value;

  set password(value) => _password.value = value;

  set confirmPassword(value) => _confirmPassword.value = value;

  set image(value) => _image.value = value;

  set loading(value) => _loading.value = value;

  onTapSuffixPassword() {
    password = !password;
  }

  onTapSuffixConfirmPassword() {
    confirmPassword = !confirmPassword;
  }

  onPickedImage() async {
    // final status = await Permission.storage.request();
    // if (status.isGranted) {
    //   final imageFile = await picker.pickImage(source: ImageSource.gallery);
    //   if (imageFile != null && imageFile.path.isNotEmpty) {
    //     image = File(imageFile.path);
    //   }
    // }
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null && imageFile.path.isNotEmpty) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Crop your image'),
        ],
      );
      if (croppedFile != null) {
        image = File(croppedFile.path);
      }
    }
  }

  validConfirmPassword(String? value) => (value == passwordController.text);

  onTapRegisterPage() {
    if (formKey.currentState!.validate()) {
      Get.to(() => const RegisterPhoto());
    }
  }

  registerUser() async {
    if (image.path.isEmpty) {
      AppMessage.showToast('الرجاء اختيار صورة');
    }
    RegisterUserRequest registerUserRequest = RegisterUserRequest(
      fullName: nameController.text,
      phoneNumber: mobileController.text,
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
      image: image,
    );
    if (formKey.currentState!.validate()) {
      loading = true;
      (await _authRepo.register(registerRequest: registerUserRequest)).fold(
        (l) {
          AppMessage.appSnackBar(el.tr(AppStrings.error), l.message);
        },
        (r) async {
          await _appPreferences.setUserToken(
            r.token!,
            r.user?.fullName ?? '',
            r.user?.phoneNumber ?? '',
            r.user?.id ?? 0,
          );
          Get.offAllNamed(AppRoutes.serviceRoute);
        },
      );
      loading = false;
    }
  }
}
