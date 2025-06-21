import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class TripCard extends StatelessWidget {
  final OrderDataResponse orderData;
  const TripCard({required this.orderData, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.w, 6.h, 22.w, 6.h),
      child: GestureDetector(
        onTap: () {
          if (orderData.seatNumber != 0) {
            Get.toNamed(AppRoutes.tripDetailsRoute, arguments: orderData);
          } else {
            AppMessage.appSnackBar(
              el.tr(AppStrings.error),
              'هذه الرحلة محجوزة بشكل كامل',
            );
          }
        },
        child: Container(
          //height: 0.3.sh,
          width: 0.75.sw,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [lowElevation],
          ),
          child: Column(
            children: [
              FromToWidget(
                from: orderData.fromPlace.orEmpty(),
                to: orderData.toPlace.orEmpty(),
                space: 10.h,
              ),
              10.verticalSpace,
              buildRowDetails(
                  label: orderData.tripFor.orEmpty(),
                  iconImage: orderData.tripFor == "مخصصة للرجال"
                      ? IconsAssets.menIcon
                      : IconsAssets.femaleIcon,
                  colorOfIcon: ColorManager.primary),
              10.verticalSpace,
              buildRowDetails(
                  label: orderData.notes.orEmpty(), iconImage: IconsAssets.pin),
              10.verticalSpace,
              buildRowDetails(
                label:
                    "${orderData.seatNumber.orZero()}/${orderData.vehicle!.seatNumber.orZero()}",
                iconImage: IconsAssets.seats,
                vehicleType: orderData.vehicleType!.type,
              ),
              10.verticalSpace,
              buildRowDetails(
                  label: convertFrom24To12HourTypes(
                    currentTime: orderData.startedAt.orEmpty(),
                  ),
                  iconImage: IconsAssets.tripTime),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRowDetails(
      {required String iconImage,
      required String label,
      String? vehicleType,
      Color? colorOfIcon}) {
    return Row(
      children: [
        SvgPicture.asset(
          iconImage,
          // ignore: deprecated_member_use
          color: colorOfIcon,
        ),
        12.horizontalSpace,
        SizedBox(width: 0.5.sw, child: CustomText(text: label)),
        const Spacer(),
        vehicleType != null
            ? SvgPicture.asset(Constants.vehicleIcon.containsKey(vehicleType)
                ? Constants.vehicleIcon[vehicleType] ?? "car"
                : Constants.vehicleIcon['car'] ?? "car")
            : const SizedBox.shrink(),
        6.horizontalSpace,
      ],
    );
  }
}
