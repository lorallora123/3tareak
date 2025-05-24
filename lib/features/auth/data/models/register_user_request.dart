import 'dart:io';

import 'package:dio/dio.dart';

class RegisterUserRequest {
  String fullName;
  String phoneNumber;
  String password;
  String passwordConfirmation;
  File? image;

  RegisterUserRequest(
      {required this.fullName,
      required this.phoneNumber,
      required this.password,
      required this.passwordConfirmation,
      this.image});

  Future<Map<String, dynamic>> toJson() async {
    return <String, dynamic>{
      'fullname': fullName,
      'phone_number': phoneNumber,
      'password': password,
      'password_confirmation': passwordConfirmation,
      if (image != null &&
          image.toString().isNotEmpty &&
          (image?.path ?? '').isNotEmpty)
        'image': await MultipartFile.fromFile(image!.path,
            filename: image!.path.split('/').last)
    };
  }
}
