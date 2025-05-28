import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/features/spin/presentation/widgets/custom_spin_wheel.dart';
import 'package:take_me_with_you/imports.dart';

class SpinScreen extends StatefulWidget {
  const SpinScreen({super.key});

  @override
  State<SpinScreen> createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> {
  // final SpinCubit spinCubit = instance<SpinCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(
          text: el.tr('دولاب الحظ'),
          style: Get.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: const AppBackButton(),
        ),
      ),
      body: Builder(
        //  BlocConsumer(
        // bloc: spinCubit,
        // listener: (context, state) {
        //   if (state is SpinFailState) {
        //     AppMessage.showToast(state.message);
        //   }
        //   if (state is SpinSuccessState) {
        //     Fluttertoast.showToast(
        //             msg: el.tr(AppStrings.thanksYouForRatting),
        //             toastLength: Toast.LENGTH_LONG,
        //             gravity: ToastGravity.BOTTOM,
        //             backgroundColor: ColorManger.primary,
        //             textColor: ColorManger.white)
        //         .then((value) => Get.offAllNamed(AppRoutes.serviceRoute));
        //   }
        // },
        builder: (context
            // , state
            ) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                60.verticalSpace,
                const CustomSpinWheel(),
                40.verticalSpace,
                // state is SpinLoadingState
                //     ? const CircularProgressIndicator()
                //     :
                // AppButton(
                //   text: el.tr(AppStrings.send),
                //   textStyle: Theme.of(context)
                //       .textTheme
                //       .bodyLarge!
                //       .copyWith(color: ColorManger.white),
                //   onTap: () {
                //     // spinCubit.spin(rate: rate);
                //   },
                //   color: ColorManger.blackText,
                //   borderRadios: AppSize.s30,
                //   width: 150.w,
                //   height: 53.h,
                // ),
                16.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
