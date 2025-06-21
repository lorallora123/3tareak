import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_back_button.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/custom_rating.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/rate_us/cubit/rate_us_cubit.dart';

import '../cubit/rate_us_state.dart';

class RateUsScreen extends StatefulWidget {
  const RateUsScreen({super.key});

  @override
  State<RateUsScreen> createState() => _RateUsScreenState();
}

class _RateUsScreenState extends State<RateUsScreen> {
  final RateUsCubit rateUsCubit = instance<RateUsCubit>();
  double rate = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(
          text: el.tr(AppStrings.rateUS),
          style: Get.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: const AppBackButton(),
        ),
      ),
      body: BlocConsumer(
        bloc: rateUsCubit,
        listener: (context, state) {
          if (state is RateUsFailState) {
            AppMessage.showToast(state.message);
          }
          if (state is RateUsSuccessState) {
            Fluttertoast.showToast(
                    msg: el.tr(AppStrings.thanksYouForRatting),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: ColorManager.primary,
                    textColor: ColorManager.white)
                .then((value) => Get.offAllNamed(AppRoutes.serviceRoute));
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: '${el.tr(AppStrings.appRating)} ',
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                30.verticalSpace,
                CustomRating(
                  rate: rate,
                  itemSize: 40.w,
                  onChange: onChanged,
                ),
                40.verticalSpace,
                state is RateUsLoadingState
                    ? const CircularProgressIndicator()
                    : AppButton(
                        text: el.tr(AppStrings.send),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ColorManager.white),
                        onTap: () {
                          rateUsCubit.rateUs(rate: rate);
                        },
                        color: ColorManager.blackText,
                        borderRadios: AppSize.s30,
                        width: 150.w,
                        height: 53.h,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  onChanged(double value) {
    rate = value;
  }
}
