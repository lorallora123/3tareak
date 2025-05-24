import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class VehicleImageList extends StatefulWidget {
  const VehicleImageList({super.key});

  @override
  State<VehicleImageList> createState() => _VehicleImageListState();
}

class _VehicleImageListState extends State<VehicleImageList> {
  final AddVehicleController controller = Get.find<AddVehicleController>();
  List<Widget> textList = [
    CustomText(
      text: "1- ${el.tr(AppStrings.mechanicsPicture)}",
      style: const TextStyle(fontSize: 14, color: ColorManger.blackText),
    ),
    CustomText(
      text: "2- ${el.tr(AppStrings.vehicleImages)}",
      style: const TextStyle(fontSize: 14, color: ColorManger.blackText),
    ),
    CustomText(
      text: "3- ${el.tr(AppStrings.idImage)}",
      style: const TextStyle(fontSize: 14, color: ColorManger.blackText),
    ),
    CustomText(
      text: "4- ${el.tr(AppStrings.personalIdentification)}",
      style: const TextStyle(fontSize: 14, color: ColorManger.blackText),
    ),
    CustomText(
      text: "5- ${el.tr(AppStrings.agencyOrAuthorization)}",
      style: const TextStyle(fontSize: 14, color: ColorManger.blackText),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<Widget> content = [];
        content.add(
          CustomText(
              text: el.tr(AppStrings.vehicleImage),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: FontSize.s15)),
        );
        content.add(
          Padding(
            padding: EdgeInsets.all(15.0.sp),
            child: textList[0],
          ),
        );
        if (controller.isShowOnly) {
          for (int i = 0; i < controller.images.length; i++) {
            content.add(
              VehicleImageWidget(
                path: controller.images[i],
                index: i,
              ),
            );
            if (i + 1 < 5) {
              content.add(
                Padding(
                  padding: EdgeInsets.all(15.0.sp),
                  child: textList[i + 1],
                ),
              );
            }
          }
        } else {
          for (int i = 0; i < controller.vehicleImages.length; i++) {
            content.add(
              VehicleImageWidget(
                path: controller.vehicleImages[i].path,
                index: i,
              ),
            );
            if (i + 1 < 5) {
              content.add(
                Padding(
                  padding: EdgeInsets.all(15.0.sp),
                  child: textList[i + 1],
                ),
              );
            }
          }
        }
        if ((controller.vehicleImages.length <= 4)) {
          content.add(
            SizedBox(
              height: 12.h,
            ),
          );
          content.add(
            controller.isShowOnly
                ? const SizedBox.shrink()
                : const AddImageWidget(),
          );
        }
        return SizedBox(
          width: 0.7.sw,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: content,
          ),
        );
      },
    );
  }
}
