import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class VehicleSelectionView extends GetView<VehicleSelectionController> {
  const VehicleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VehicleSelectionAppBar(onTap: () {
        Get.off(() => const ServiceView());
      }),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 81.w, left: 66.w),
        child: Obx(
          () => controller.loading
              ? SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : controller.vehicleModel.vehicles!.isNotEmpty
                  ? Column(
                      children: [
                        39.verticalSpace,
                        ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedVehicle.value =
                                      controller.vehicleModel.vehicles![index];
                                },
                                child: VehicleItem(
                                  model:
                                      controller.vehicleModel.vehicles![index],
                                  onDetailsTap: () async {
                                    controller.selectedVehicle.value =
                                        controller
                                            .vehicleModel.vehicles![index];
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    Get.toNamed(
                                      AppRoutes.addVehicleRoute,
                                      arguments: controller
                                          .vehicleModel.vehicles![index],
                                    );
                                  },
                                ),
                              );
                            },
                            itemCount: controller.vehicleModel.vehicles!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics()),
                        26.verticalSpace,
                        const AddVehicleWidget(),
                        100.verticalSpace,
                      ],
                    )
                  : SizedBox(
                      width: 1.sw,
                      height: 0.8.sh,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AddVehicleWidget(),
                        ],
                      ),
                    ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => controller.selectedVehicle.value.id == null
            ? const SizedBox()
            : AppButton(
                onTap: () => Get.toNamed(AppRoutes.createTripRoute,
                    arguments: {'isPrivate': false}),
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: ColorManger.white),
                text: el.tr(AppStrings.next),
                color: ColorManger.blackText,
                borderRadios: AppSize.s30,
                width: 346.w,
                height: 53.h,
              ),
      ),
    );
  }
}
