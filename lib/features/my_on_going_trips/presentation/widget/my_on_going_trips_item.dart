import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:take_me_with_you/core/models/trip_response.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/extensions.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/core/widgets/from_to_widget.dart';
import 'package:take_me_with_you/features/cancel_trip/presentation/getx/call_cancel_trip_bottom_sheet.dart';

import 'status_widget.dart';

class MyOnGoingTripsItem extends StatelessWidget {
  final void Function()? onTap;
  final TripDataResponse model;
  final int availableSeats;

  const MyOnGoingTripsItem(
      {required this.model,
      this.onTap,
      required this.availableSeats,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              StatusWidget(model: model),
              Container(
                width: 341.w,
                padding: EdgeInsets.only(
                    right: 21.w, top: 20.h, left: 19.w, bottom: 33.h),
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    boxShadow: getBoxShadow(),
                    borderRadius: BorderRadius.circular(AppSize.s30)),
                child: Column(
                  children: [
                    FromToWidget(
                        from: model.fromPlace.orEmpty(),
                        to: model.toPlace.orEmpty()),
                    25.verticalSpace,
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconsAssets.notes,
                          width: 17.w,
                          height: 17.h,
                        ),
                        16.horizontalSpace,
                        CustomText(
                            text: model.notes.orEmpty(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 15.sp))
                      ],
                    ),
                    25.verticalSpace,
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconsAssets.seats,
                          width: 14.w,
                          height: 21.h,
                        ),
                        6.horizontalSpace,
                        if (model.vehicle?.seatNumber != null &&
                            model.seatNumber != null)
                          CustomText(
                              text: model.seatNumber!.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 15.sp)),
                        const Spacer(),
                        SvgPicture.asset(IconsAssets.tripTime),
                        8.horizontalSpace,
                        CustomText(
                            text: convertFrom24To12HourTypes(
                                    currentTime: model.startedAt.toString())
                                .orEmpty(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 15.sp)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          11.verticalSpace,
          if (model.status == "pending")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => callCancelTripBottomSheet(model.id!),
                  child: CustomText(
                      text: AppStrings.cancelTrip.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 15.sp)),
                ),
                5.horizontalSpace,
              ],
            )
        ],
      ),
    );
  }
}
