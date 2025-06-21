import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/extensions.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/core/widgets/from_to_widget.dart';

class MyOldTripsWidget extends StatelessWidget {
  final TripDataResponse model;

  const MyOldTripsWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.lazyPut(() => OldTripController());
        // Get.off(() => const OldTripView(), arguments: model.id);
      },
      child: Container(
        width: 341.w,
        padding: EdgeInsets.only(top: 20.h, bottom: 17.h),
        decoration: BoxDecoration(
            color: ColorManager.white,
            boxShadow: getBoxShadow(),
            borderRadius: BorderRadius.circular(AppSize.s7)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 22.0.w),
              child: FromToWidget(
                  from: model.fromPlace.orEmpty(), to: model.toPlace.orEmpty()),
            ),
            18.98.verticalSpace,
            if (model.reservedSeats != null &&
                model.reservedSeats!.isNotEmpty) ...[
              const Divider(color: ColorManager.iconLightGreyColor),
              14.verticalSpace,
              Padding(
                padding: EdgeInsets.only(right: 28.0.w, left: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: el.tr(AppStrings.grossProfit),
                        style: Theme.of(context).textTheme.titleMedium!),
                    CustomText(
                        text:
                            "${model.captainProfit.orZero() * int.parse(model.reservedSeats.toString())} ${el.tr(AppStrings.sp)}",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: ColorManager.blueColor, fontSize: 15.sp)),
                  ],
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
