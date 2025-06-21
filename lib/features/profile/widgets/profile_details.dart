import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/styles_manger.dart';

class Profiledetails extends StatelessWidget {
  const Profiledetails({
    super.key,
    required this.sized,
    required this.onpressed,
    required this.text,
  });

  final Size sized;
  final dynamic onpressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sized.height * 0.005),
      child: TextButton(
        onPressed: onpressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sized.width * 0.01),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              text,
              style: getRegularStyle(
                color: ColorManager.blackText,
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Divider profileDivider = Divider(
  color: const Color.fromARGB(160, 196, 195, 195),
  height: 1,
  thickness: 0.5,
  indent: 4,
  endIndent: 4,
);
