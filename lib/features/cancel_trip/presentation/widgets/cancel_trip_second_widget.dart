import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/cancel_trip/presentation/getx/cancel_trip_controller.dart';

class CancelTripSecondWidget extends GetView<CancelTripController> {
  const CancelTripSecondWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
            text: el.tr(AppStrings.theReasonForCancelingTheTrip),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 20.sp)),
        34.verticalSpace,
        DropdownButtonFormField(
          items: controller.items,
          onChanged: controller.onChangedCancelReason,
          iconEnabledColor: ColorManager.primary,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  borderSide: BorderSide(
                      color: ColorManager.primary.withOpacity(0.12))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  borderSide: BorderSide(
                      color: ColorManager.primary.withOpacity(0.12))),
              filled: true,
              fillColor: ColorManager.primary.withOpacity(0.12)),
        ),
        38.verticalSpace,
        Obx(
          () => controller.loading
              ? const CircularProgressIndicator()
              : GestureDetector(
                  onTap: controller.cancelOrder,
                  child: CustomText(
                      text: el.tr(AppStrings.ok),
                      style: Theme.of(context).textTheme.displayLarge!),
                ),
        )
      ],
    );
  }
}
