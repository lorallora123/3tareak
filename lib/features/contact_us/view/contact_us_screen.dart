import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/app_message.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/app_back_button.dart';
import 'package:take_me_with_you/core/widgets/app_button.dart';
import 'package:take_me_with_you/core/widgets/app_text_filed.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:take_me_with_you/features/contact_us/cubit/contact_us_state.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  ContactUsCubit contactUsCubit = instance<ContactUsCubit>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(
          text: el.tr(AppStrings.contactUs),
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
        bloc: contactUsCubit,
        listener: (context, state) {
          if (state is ContactUsFailState) {
            AppMessage.showToast(state.message);
          }
          if (state is ContactUsSuccessState) {
            Fluttertoast.showToast(
                    msg: el.tr(AppStrings.contactUsSuccess),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: ColorManager.primary,
                    textColor: ColorManager.white)
                .then((value) => Get.offAllNamed(AppRoutes.serviceRoute));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextFiled(
                    prefixIcon: Icons.title,
                    label: el.tr(AppStrings.title),
                    keyboardType: TextInputType.text,
                    action: TextInputAction.next,
                    controller: titleController,
                    validator: validMinChars,
                  ),
                  18.verticalSpace,
                  AppTextFiled(
                    prefixIcon: Icons.description,
                    label: el.tr(AppStrings.description),
                    keyboardType: TextInputType.text,
                    action: TextInputAction.next,
                    controller: descriptionController,
                    validator: validMinChars,
                    maxLine: 4,
                  ),
                  100.verticalSpace,
                  state is ContactUsLoadingState
                      ? const CircularProgressIndicator()
                      : AppButton(
                          text: el.tr(AppStrings.send),
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: ColorManager.white),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              contactUsCubit.contactUs(
                                title: titleController.text,
                                desc: descriptionController.text,
                              );
                            }
                          },
                          color: ColorManager.blackText,
                          borderRadios: AppSize.s30,
                          width: 253.w,
                          height: 53.h,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
