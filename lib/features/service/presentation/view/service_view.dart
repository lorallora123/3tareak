import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/extensions.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';
import 'package:take_me_with_you/features/profile/profile_page.dart';
import 'package:take_me_with_you/features/service/presentation/getx/service_controller.dart';
import 'package:take_me_with_you/features/service/presentation/view/nav_bar_taps.dart';
import 'package:take_me_with_you/features/service/presentation/view/service_drawer.dart';
import 'package:take_me_with_you/features/service/presentation/widgets/service_widget.dart';
import 'package:take_me_with_you/features/trip_page.dart';

class ServiceView extends GetView<ServiceController> {
  const ServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 2.obs;

    final List<Widget> pages = [
      const ProfilePage(), // index 0
      const TripPage(), // index 1
      homePageBody(controller), // index 2
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: const ServiceDrawer(drawerType: DrawerType.normal),
        body: Stack(
          children: [
            Container(width: 1.sw, height: 1.sh, color: ColorManager.white),
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                IconsAssets.lightRoadBackground,
                fit: BoxFit.cover,
              ),
            ),
            Obx(
              () => IndexedStack(index: selectedIndex.value, children: pages),
            ),
            nav_bar_taps(selectedIndex),
          ],
        ),
      ),
    );
  }

  static Widget homePageBody(ServiceController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 70.h),
      child: Column(
        children: [
          45.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              19.horizontalSpace,
              GestureDetector(
                onTap: () {
                  controller.scaffoldKey.currentState!.openDrawer();
                },
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: ColorManager.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.menu,
                      size: 30.w,
                      color: ColorManager.blackText,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            IconsAssets.logo,
            width: 75.w,
            height: 75.h,
            fit: BoxFit.cover,
          ),
          30.verticalSpace,
          ServiceWidget(
            onTap: () => Get.toNamed(AppRoutes.vehicleSelectionRoute),
            title: el.tr(AppStrings.deliveryTrip),
            image: IconsAssets.deliveryTrip,
          ),
          35.verticalSpace,
          ServiceWidget(
            onTap: () {
              (controller.userDataModel.user?.tripStatus).orEmpty().isEmpty
                  ? Get.toNamed(AppRoutes.availableTripsRoute)
                  : Get.toNamed(
                      AppRoutes.liveTripRoute,
                      arguments:
                          controller.userDataModel.user?.tripStatus.orEmpty(),
                    );
            },
            title: el.tr(AppStrings.orderARide),
            image: IconsAssets.orderARide,
          ),
          35.verticalSpace,
        ],
      ),
    );
  }
}


// ServiceWidget(
                  //     onTap: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return const SpinScreen();
                  //       }));
                  //     },
                  //     title: el.tr("دولاب الحظ"),
                  //     image: IconsAssets.percent),
