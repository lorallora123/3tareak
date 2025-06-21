import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';

import 'custom_text.dart';

// ignore: must_be_immutable
class AppTextFiled extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextStyle? textStyle;
  final TextInputAction? action;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final void Function()? onTap;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onSuffixIcon;
  final double? width;
  final double? height;
  final bool? isSvg;
  final String? svgPrefixIcon;
  final TextDirection? textDirection;
  final String? suffixText;
  final bool isSuffixText;
  final AutovalidateMode? autoValidateMode;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextAlign? textAlign;
  final bool? enabled;
  int maxLine;

  final List<TextInputFormatter>? inputFormatters;

  AppTextFiled(
      {super.key,
      this.label,
      this.maxLine = 1,
      this.hint,
      this.action,
      this.controller,
      this.onTap,
      this.onChanged,
      this.keyboardType,
      this.isPassword = false,
      this.validator,
      this.onSuffixIcon,
      this.prefixIcon,
      this.suffixIcon,
      this.width,
      this.height,
      this.isSvg = false,
      this.svgPrefixIcon,
      this.textDirection,
      this.suffixText,
      this.isSuffixText = false,
      this.floatingLabelBehavior = FloatingLabelBehavior.never,
      this.textAlign = TextAlign.start,
      this.textStyle,
      this.enabled = true,
      this.autoValidateMode = AutovalidateMode.onUserInteraction,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      textInputAction: action,
      maxLines: maxLine,
      enabled: enabled,
      autovalidateMode: autoValidateMode,
      textDirection: textDirection,
      keyboardType: keyboardType,
      obscureText: isPassword!,
      style: textStyle ??
          Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15.sp),
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      textAlign: textAlign!,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        labelText: label,
        labelStyle:
            Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15.sp),
        floatingLabelBehavior: floatingLabelBehavior,
        prefixIcon: isSvg!
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  svgPrefixIcon!,
                  fit: BoxFit.fitWidth,
                ),
              )
            : prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: ColorManager.primary,
                    size: 16.w,
                  )
                : null,
        prefixText: suffixText != null ? '$suffixText\t' : '',
        prefixStyle:
            Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15.sp),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        hintStyle: Theme.of(context).textTheme.headlineMedium,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixIcon,
                child: isSuffixText
                    ? CustomText(
                        text: suffixText!,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 16))
                    : Icon(
                        suffixIcon,
                        color: ColorManager.iconGreyColor,
                      ))
            : null,
      ),
    );
  }
}
