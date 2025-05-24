import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/widgets/app_back_button.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/my_on_going_trips/presentation/getx/my_on_going_trips_controller.dart';

class MyOnGoingTripsAppBar extends GetView<MyOnGoingTripsController>
    implements PreferredSizeWidget {
  const MyOnGoingTripsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: CustomText(
          text: el.tr(AppStrings.onGoingTravel),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 20.sp)),
      actions: [
        const Directionality(
            textDirection: TextDirection.rtl, child: AppBackButton()),
        22.horizontalSpace
      ],
      // leading: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     19.horizontalSpace,
      //     GestureDetector(
      //       onTap: () => controller.scaffoldKey.currentState!.openDrawer(),
      //       child: Container(
      //         width: 40.w,
      //         height: 40.w,
      //         decoration: BoxDecoration(
      //             color: ColorManger.white, shape: BoxShape.circle),
      //         child: Center(
      //           child: Icon(
      //             Icons.menu,
      //             size: 30.w,
      //             color: ColorManger.blackText,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      // leadingWidth: 76.w,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
