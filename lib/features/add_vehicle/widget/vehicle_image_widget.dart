import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class VehicleImageWidget extends GetView<AddVehicleController> {
  final String path;
  final int index;

  const VehicleImageWidget(
      {required this.path, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: 142.h,
          width: 152.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s14),
              child: controller.isShowOnly
                  ? AppImage(
                      imageUrl: path,
                      boxFit: BoxFit.cover,
                    )
                  : Image.file(
                      File(path),
                      fit: BoxFit.cover,
                    )),
        ),
        if (!controller.isShowOnly &&
            controller.vehicleImages.length - 1 == index)
          GestureDetector(
            onTap: () => controller.deleteVehicleImage(index),
            child: Container(
              width: 22.w,
              height: 18.h,
              decoration: BoxDecoration(
                  color: ColorManger.blackText.withOpacity(0.68),
                  shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 18.w,
                  color: ColorManger.white,
                ),
              ),
            ),
          )
      ],
    );
  }
}
