import 'package:flutter/material.dart';
import 'package:rate/rate.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';

class CustomRating extends StatelessWidget {
  final double rate;
  final double itemSize;
  final bool readOnly;
  final void Function(double)? onChange;

  const CustomRating(
      {required this.rate,
      required this.itemSize,
      this.readOnly = false,
      this.onChange,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Rate(
        iconSize: itemSize,
        color: ColorManager.yellowColor,
        allowHalf: true,
        allowClear: true,
        initialValue: rate,
        readOnly: readOnly,
        onChange: onChange,
      ),
    );
  }
}
