import 'dart:io';
import 'package:dio/dio.dart';

class UpdateProfileRequest {
  final String? fullname;
  final String? phoneNumber;
  final String? newPassword;
  final File? image;

  UpdateProfileRequest({
    this.fullname,
    this.phoneNumber,
    this.newPassword,
    this.image,
  });

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> data = {};

    // Only include fields that are not null and not empty
    if (fullname != null && fullname!.trim().isNotEmpty) {
      data['fullname'] = fullname!.trim();
    }

    if (phoneNumber != null && phoneNumber!.trim().isNotEmpty) {
      data['phone_number'] = phoneNumber!.trim();
    }

    if (newPassword != null && newPassword!.trim().isNotEmpty) {
      data['new_password'] = newPassword!.trim();
    }

    if (image != null) {
      data['image'] = await MultipartFile.fromFile(
        image!.path,
        filename: "profile_image.jpg",
      );
    }

    return data;
  }

  // Check if any field has been modified
  bool get hasChanges {
    return (fullname != null && fullname!.trim().isNotEmpty) ||
        (phoneNumber != null && phoneNumber!.trim().isNotEmpty) ||
        (newPassword != null && newPassword!.trim().isNotEmpty) ||
        image != null;
  }
}
