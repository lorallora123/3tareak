import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/styles_manger.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset(
                      IconsAssets.lightRoadBackground,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IconsAssets.logo,
                        width: 75.w,
                        height: 75.h,
                        fit: BoxFit.cover,
                      ),
                      30.verticalSpace,
                      Text(
                        'ملفك الشخصي',
                        style: getBoldStyle(
                          color: ColorManger.blackText,
                          fontSize: 20.sp,
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        height: 220,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: ColorManger.primary,
                                child: controller.imageUrl.value.isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          'https://3tre2k.nashwati.com/${controller.imageUrl.value}',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.person,
                                                size: 50, color: Colors.white);
                                          },
                                        ),
                                      )
                                    : const Icon(Icons.person,
                                        size: 50, color: Colors.white),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "اسمك: ",
                                    style: getRegularStyle(
                                      color: ColorManger.blackText,
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                  Text(
                                    controller.fullname.value,
                                    style: getRegularStyle(
                                      color: ColorManger.blackText,
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "رقمك: ",
                                    style: getRegularStyle(
                                      color: ColorManger.blackText,
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                  Text(
                                    controller.phoneNumber.value,
                                    style: getRegularStyle(
                                      color: ColorManger.blackText,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        height: 55,
                        width: 350,
                        decoration: BoxDecoration(
                          color: ColorManger.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text('تسجيل خروج'),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        height: 55,
                        width: 350,
                        decoration: BoxDecoration(
                          color: ColorManger.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text('حذف الحساب'),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
