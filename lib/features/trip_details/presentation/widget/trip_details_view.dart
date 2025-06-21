import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:take_me_with_you/imports.dart';

class TripDetailsView extends StatelessWidget {
  final OrderDataResponse orderData;

  const TripDetailsView({Key? key, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          20.verticalSpace,
          FromToWidget(
            from: orderData.fromPlace.orEmpty(),
            to: orderData.toPlace.orEmpty(),
          ),
          20.verticalSpace,
          buildDivider(),
          buildRowDetails(
            iconImage: IconsAssets.seats,
            label: 'عدد المقاعد المتاحة',
            detail:
                "${orderData.seatNumber.orZero()}/${orderData.vehicle!.seatNumber.orZero()}",
          ),
          buildRowDetails(
            iconImage: IconsAssets.pin,
            label: 'مسار الرحلة',
            detail: orderData.notes.orEmpty(),
          ),
          buildRowDetails(
            iconImage: IconsAssets.car,
            label: 'اسم السائق',
            detail: orderData.captain!.user!.fullName.orEmpty(),
          ),
          buildRowDetails(
            iconImage: IconsAssets.tripTime,
            label: 'وقت الرحلة',
            detail: convertFrom24To12HourTypes(
              currentTime: orderData.startedAt.orEmpty(),
            ).orEmpty(),
          ),
          buildRowDetails(
            iconImage: IconsAssets.vehicleType,
            label: 'المركبة',
            detail: orderData.vehicle!.model.orEmpty(),
          ),
        ],
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      indent: 6.w,
      endIndent: 7.w,
      color: ColorManager.iconLightGreyColor,
    );
  }

  Widget buildRowDetails(
      {required String iconImage,
      required String label,
      required String detail}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(iconImage),
              12.horizontalSpace,
              CustomText(text: label),
              const Spacer(),
              SizedBox(width: 0.3.sw, child: CustomText(text: detail)),
            ],
          ),
        ),
        buildDivider(),
      ],
    );
  }
}
