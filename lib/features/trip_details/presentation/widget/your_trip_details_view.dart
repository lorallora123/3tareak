import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class YourTripDetailsView extends GetView<TripDetailsController> {
  const YourTripDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          const TripRouteMap(),
          30.verticalSpace,
          buildRowDetails(
            iconImage: IconsAssets.seats,
            label: 'عدد المقاعد',
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: SizedBox(
              height: 50.h,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SeatsNumberContainer(
                        onTap: () {
                          controller.joinOrderRequest.seatNumber = index + 1;
                          return controller.numSeats = index + 1;
                        },
                        color: controller.numSeats == index + 1
                            ? ColorManager.primary
                            : ColorManager.textGrueColor,
                        index: index,
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => 25.horizontalSpace,
                  itemCount: controller.orderData.seatNumber ?? 0),
            ),
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

  Widget buildRowDetails({required String iconImage, required String label}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            children: [
              SvgPicture.asset(iconImage),
              12.horizontalSpace,
              CustomText(text: label),
            ],
          ),
        ),
      ],
    );
  }
}
