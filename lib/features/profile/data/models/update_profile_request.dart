import 'dart:io';
import 'package:dio/dio.dart';

class UpdateProfileRequest {
  final String? fullname;
  final String? phoneNumber;
  final String? password;
  final String? newPassword;
  final String? newPasswordConfirmation;
  final File? image;

  UpdateProfileRequest({
    this.fullname,
    this.phoneNumber,
    this.password,
    this.newPassword,
    this.newPasswordConfirmation,
    this.image,
  });

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> data = {};
    data['fullname'] = fullname ?? '';
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      data['phone_number'] = phoneNumber;
    }
    if (password != null && password!.isNotEmpty) {
      data['password'] = password;
      data['new_password'] = newPassword ?? '';
      data['new_password_confirmation'] = newPasswordConfirmation ?? '';
    }
    if (image != null) {
      data['image'] = await MultipartFile.fromFile(
        image!.path,
        filename: "profile_image.jpg",
      );
    }
    return data;
  }

  bool get hasChanges {
    return (fullname != null && fullname!.trim().isNotEmpty) ||
        (phoneNumber != null && phoneNumber!.trim().isNotEmpty) ||
        (password != null && password!.trim().isNotEmpty) ||
        (newPassword != null && newPassword!.trim().isNotEmpty) ||
        (newPasswordConfirmation != null &&
            newPasswordConfirmation!.trim().isNotEmpty) ||
        image != null;
  }
}
