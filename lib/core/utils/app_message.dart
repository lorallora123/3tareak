import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

class AppMessage {
  static void appSnackBar(String title, String message) {
    Get.snackbar(title, message,
        titleText: CustomText(
          text: title,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge!
              .copyWith(color: ColorManager.white),
        ),
        messageText: Text(
          message,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorManager.white),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorManager.primary);
  }

  static Future<void> showToast(String message) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorManager.primary,
        textColor: ColorManager.white);
  }
}
