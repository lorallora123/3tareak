import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/imports.dart';

class CreateTripAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isPrivate;

  const CreateTripAppBar({super.key, required this.isPrivate});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
          text: isPrivate
              ? el.tr(AppStrings.privateOnGoingDelivery)
              : el.tr(AppStrings.onGoingDelivery),
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
