import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/app_back_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

class OnGoingTripAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnGoingTripAppBar({super.key, required this.onPress});
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
          text: el.tr(AppStrings.onGoingTrip),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 20.sp)),
      leading: Row(
        children: [22.horizontalSpace, AppBackButton(onTap: onPress)],
      ),
      leadingWidth: 76.w,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
