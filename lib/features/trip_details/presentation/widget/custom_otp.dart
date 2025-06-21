import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:take_me_with_you/imports.dart';

class CustomOtp extends StatefulWidget {
  const CustomOtp({
    super.key,
    required this.defaultPinTheme,
  });

  final PinTheme defaultPinTheme;

  @override
  State<CustomOtp> createState() => _CustomOtpState();
}

class _CustomOtpState extends State<CustomOtp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        autofocus: true,
        animationCurve: Curves.bounceIn,
        closeKeyboardWhenCompleted: true,
        onCompleted: (value) {},
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        length: 4,
        defaultPinTheme: widget.defaultPinTheme.copyBorderWith(
          border: Border.merge(
            const Border(
              bottom: BorderSide(
                color: ColorManager.iconGreyColor,
              ),
            ),
            const Border(
              bottom: BorderSide(
                color: ColorManager.iconGreyColor,
              ),
            ),
          ),
        ),
        focusedPinTheme: widget.defaultPinTheme,
      ),
    );
  }
}
