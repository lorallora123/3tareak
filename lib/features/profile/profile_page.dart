import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/features/profile/widgets/custom_button.dart';
import 'package:take_me_with_you/features/profile/widgets/profile_card.dart';
import 'package:take_me_with_you/features/profile/widgets/profile_details.dart';
import 'package:take_me_with_you/imports.dart';
import 'controllers/profile_controller.dart';
import 'package:take_me_with_you/features/profile/edit_profile_view.dart';
import 'package:take_me_with_you/features/profile/widgets/about_app_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  String _buildImageUrl(String imagePath) {
    if (imagePath.isEmpty || imagePath == 'null') {
      return '';
    }

    String cleanPath =
        imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    return 'https://3tre2k.nashwati.com/storage/app/public/$cleanPath';
  }

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    ServiceController serviceController = Get.put(ServiceController());

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
                    return const Center(
                        child: CircularProgressIndicator(
                            color: ColorManager.primary));
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 340,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Get.to(() => const EditProfileView());
                                  },
                                  backgroundColor: ColorManager.primary,
                                  elevation: 4,
                                  mini: true,
                                  child: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                              ),
                              10.verticalSpace,
                              Text(
                                'ملفك الشخصي',
                                style: getBoldStyle(
                                  color: ColorManager.blackText,
                                  fontSize: 25.sp,
                                ),
                              ),
                              20.verticalSpace,
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: ColorManager.primary,
                                child: (controller.imageUrl.value.isNotEmpty &&
                                        controller.imageUrl.value != 'null')
                                    ? ClipOval(
                                        child: Image.network(
                                          _buildImageUrl(
                                              controller.imageUrl.value),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.person,
                                              size: 50,
                                              color: Colors.white,
                                            );
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Container(
                                              color: Colors.grey[300],
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
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
                                      color: ColorManager.blackText,
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                  Text(
                                    controller.fullname.value,
                                    style: getRegularStyle(
                                      color: ColorManager.blackText,
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
                                      color: ColorManager.blackText,
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                  Text(
                                    controller.phoneNumber.value,
                                    style: getRegularStyle(
                                      color: ColorManager.blackText,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      40.verticalSpace,
                      ProfileCard(
                        sized: sized,
                        child: Column(
                          children: [
                            Profiledetails(
                              sized: sized,
                              onpressed: () {},
                              text: 'خدمة العملاء',
                            ),
                            profileDivider,
                            Profiledetails(
                              sized: sized,
                              onpressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AboutAppDialog(),
                                );
                              },
                              text: 'عن التطبيق',
                            ),
                            profileDivider,
                            Profiledetails(
                              sized: sized,
                              onpressed: () {},
                              text: 'سياسة الخصوصية',
                            ),
                          ],
                        ),
                      ),
                      40.verticalSpace,
                      Obx(
                        () => serviceController.loadingLogOut.value
                            ? const CircularProgressIndicator()
                            : customButton(
                                onTap: () async {
                                  bool confirm = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'هل أنت متأكد من تسجيل الخروج؟',
                                          style: getSemiBoldStyle(
                                            color: ColorManager.blackText,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text(
                                            'إلغاء',
                                            style: getRegularStyle(
                                              color: ColorManager.blackText,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text(
                                            'تأكيد',
                                            style: getRegularStyle(
                                              color: ColorManager.primary,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm) {
                                    await serviceController.logout();
                                  }
                                },
                                text: 'تسجيل خروج',
                              ),
                      ),
                      20.verticalSpace,
                      customButton(
                        onTap: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.white,
                              content: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'هل أنت متأكد من حذف حسابك؟',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.blackText,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text(
                                    'إلغاء',
                                    style: getRegularStyle(
                                      color: ColorManager.blackText,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text(
                                    'تأكيد',
                                    style: getRegularStyle(
                                      color: ColorManager.primary,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirm) {
                            await serviceController.deleteAccount();
                          }
                        },
                        text: 'حذف حسابك',
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
