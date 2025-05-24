import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:take_me_with_you/core/models/customer_trips_response.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/extensions.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/core/widgets/from_to_widget.dart';

class MyOldOrdersWidget extends StatelessWidget {
  const MyOldOrdersWidget({required this.customerTrip, super.key});

  final CustomerTripDataResponse customerTrip;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.lazyPut(() => OldOrderController());
        // Get.off(() => const OldOrderView(), arguments: customerTrip.orderId);
      },
      child: Container(
        width: 341.w,
        padding: EdgeInsets.only(top: 20.h, bottom: 17.h),
        decoration: BoxDecoration(
            color: ColorManger.white,
            boxShadow: getBoxShadow(),
            borderRadius: BorderRadius.circular(AppSize.s7)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 22.0.w),
              child: FromToWidget(
                from: customerTrip.from.orEmpty(),
                to: customerTrip.to.orEmpty(),
              ),
            ),
            18.98.verticalSpace,
            const Divider(color: ColorManger.iconLightGreyColor,),
            14.verticalSpace,
            Padding(
              padding: EdgeInsets.only(right: 28.0.w, left: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: el.tr(AppStrings.amountPaid),
                      style: Theme.of(context).textTheme.titleMedium!),
                  CustomText(
                      text:
                          "${int.parse(customerTrip.price.toString()) * int.parse(customerTrip.seatNumber.toString())} ل.س ",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: ColorManger.blueColor, fontSize: 15.sp)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
