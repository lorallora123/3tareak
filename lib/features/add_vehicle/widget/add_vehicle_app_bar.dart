import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class AddVehicleAppBar extends GetView<AddVehicleController>
    implements PreferredSizeWidget {
  const AddVehicleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
          text: controller.isShowOnly
              ? el.tr(AppStrings.vehicleInfo)
              : el.tr(AppStrings.addVehicle),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 20.sp)),
      leading: Row(
        children: [22.horizontalSpace, const AppBackButton()],
      ),
      leadingWidth: 76.w,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
