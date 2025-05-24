import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const CustomText(
      {super.key,
      required this.text,
      this.style,
      this.textAlign = TextAlign.start,
      this.overflow,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style ?? Get.textTheme.titleMedium,
      maxLines: maxLine,
      overflow: overflow,
      // ignore: deprecated_member_use
      textScaleFactor: Constants.scale,
    );
  }
}
