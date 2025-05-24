import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/extensions.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';
import 'package:take_me_with_you/features/contact_us/view/contact_us_screen.dart';
import 'package:take_me_with_you/features/rate_us/view/rate_us_screen.dart';
import 'package:take_me_with_you/features/service/presentation/getx/service_controller.dart';
import 'package:take_me_with_you/features/service/presentation/widgets/drawer_item.dart';
import 'package:take_me_with_you/features/service/presentation/widgets/personal_info.dart';

class ServiceDrawer extends GetView<ServiceController> {
  final DrawerType drawerType;

  const ServiceDrawer({required this.drawerType, super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 220.w,
        height: 1.sh,
        decoration: const BoxDecoration(
          color: ColorManger.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s20),
            bottomLeft: Radius.circular(AppSize.s20),
          ),
        ),
        child: Obx(
          () =>
              controller.loading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        150.verticalSpace,
                        PersonalInfo(drawerType: drawerType),
                        35.verticalSpace,
                        if (drawerType == DrawerType.captain &&
                            controller.userDataModel.user!.captain != null) ...[
                          Container(
                            width: 183.w,
                            padding: EdgeInsets.symmetric(
                              vertical: 5.h,
                              horizontal: 5.w,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManger.primary.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(AppSize.s7),
                            ),
                            child: Center(
                              child: CustomText(
                                text:
                                    "${el.tr(AppStrings.amount)} : ${controller.userDataModel.user!.captain!.balance}",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontSize: 15.sp),
                              ),
                            ),
                          ),
                          16.verticalSpace,
                        ],
                        if (controller.userDataModel.user?.captain != null)
                          Container(
                            padding: EdgeInsets.only(right: 10.w, left: 10.w),
                            width: 183.w,
                            height: 42.h,
                            decoration: BoxDecoration(
                              color: ColorManger.primary.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(AppSize.s7),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  CustomText(
                                    text: "الرصيد: ",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 15.sp),
                                  ),
                                  2.horizontalSpace,
                                  Expanded(
                                    child: CustomText(
                                      text:
                                          controller
                                              .userDataModel
                                              .user
                                              ?.captain
                                              ?.balance ??
                                          "",
                                      textAlign: TextAlign.center,
                                      maxLine: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15.sp),
                                    ),
                                  ),
                                  2.horizontalSpace,
                                  CustomText(
                                    text: "ل.س",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        16.verticalSpace,
                        if (controller.userDataModel.user?.captain != null)
                          DrawerItem(
                            title: el.tr(AppStrings.myTravel),
                            icon: IconsAssets.myTravels,
                            children: [
                              el.tr(AppStrings.onGoingTravel),
                              el.tr(AppStrings.previousTravel),
                            ],
                            onTapChildren: [
                              () => Get.toNamed(AppRoutes.myOnGoingTripsRoute),
                              () => Get.toNamed(AppRoutes.myOldTripsRoute),
                            ],
                          ),
                        DrawerItem(
                          title: el.tr(AppStrings.myOrders),
                          icon: IconsAssets.myOrders,
                          children: [
                            el.tr(AppStrings.onGoingOrder),
                            el.tr(AppStrings.myPreviousOrder),
                          ],
                          onTapChildren: [
                            () => Get.toNamed(
                              AppRoutes.liveTripRoute,
                              arguments:
                                  controller.userDataModel.user?.tripStatus
                                      .orEmpty(),
                            ),
                            () => Get.toNamed(AppRoutes.myOldOrdersRoute),
                          ],
                        ),
                        if (drawerType == DrawerType.captain)
                          // DrawerItem(
                          //   title: el.tr(AppStrings.myProfit),
                          //   icon: IconsAssets.profit,
                          //   onTap: () => Get.toNamed(AppRoutes.profitRoute),
                          //       ),
                          DrawerItem(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ContactUsScreen();
                                  },
                                ),
                              );
                            },
                            title: el.tr(AppStrings.contactUs),
                            icon: IconsAssets.contactUs,
                          ),
                        DrawerItem(
                          title: el.tr(AppStrings.rateUS),
                          icon: IconsAssets.rateUs,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RateUsScreen();
                                },
                              ),
                            );
                          },
                        ),

                        28.verticalSpace,
                        Obx(
                          () =>
                              controller.loadingLogOut.value
                                  ? const CircularProgressIndicator()
                                  : GestureDetector(
                                    onTap:
                                        () async => await controller.logout(),
                                    child: CustomText(
                                      text: el.tr(AppStrings.signOut),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(fontSize: 15.sp),
                                    ),
                                  ),
                        ),
                        32.verticalSpace,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     CustomText(
                        //         text: "${AppStrings.developByel.tr()} ",
                        //         style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12.sp)),
                        //     CustomText(
                        //         text: AppStrings.futureCodeel.tr(),
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .titleMedium!
                        //             .copyWith(fontSize: 12.sp, decoration: TextDecoration.underline)),
                        //   ],
                        // ),
                        // 35.verticalSpace,
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
