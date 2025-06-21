import 'package:flutter/material.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';

GestureDetector customButton({required dynamic onTap, required String text}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 55,
      width: 350,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Text(text),
      ),
    ),
  );
}
