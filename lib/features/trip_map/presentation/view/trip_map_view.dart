import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/features/trip_map/presentation/getx/trip_map_controller.dart';
import 'package:take_me_with_you/imports.dart';

class TripMapView extends GetView<TripMapController> {
  const TripMapView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => SizedBox(
              height: Get.height,
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.04),
                      child: GoogleMap(
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        polylines:
                            Set<Polyline>.of(controller.polyLines.values),
                        markers: {
                          controller.origin.value,
                          controller.destination.value
                        },
                        onTap: (pos) {},
                        initialCameraPosition: controller.cameraPosition.value,
                        onMapCreated: controller.onMapCreated,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.04),
            child: const Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(AppSize.s16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [AppBackButton()]))
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        text: el.tr(AppStrings.ok),
        onTap: () => Get.back(),
        color: ColorManager.blackText,
        textStyle: Get.textTheme.bodyLarge!.copyWith(color: ColorManager.white),
        borderRadios: AppSize.s20,
        width: 354.w,
        height: 60.h,
      ),
    );
  }
}
