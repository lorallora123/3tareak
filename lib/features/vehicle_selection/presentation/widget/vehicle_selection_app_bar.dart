import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/imports.dart';

class VehicleSelectionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final void Function()? onTap;

  const VehicleSelectionAppBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [],
      backgroundColor: Colors.transparent,
      leadingWidth: 76.w,
      leading: Row(
        children: [
          22.horizontalSpace,
          AppBackButton(
            onTap: onTap,
          )
        ],
      ),
      title: CustomText(
          text: el.tr(AppStrings.vehicleSelection),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 20.sp)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
