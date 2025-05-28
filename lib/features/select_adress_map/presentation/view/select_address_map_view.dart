import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/imports.dart';

class SelectAddressMapView extends GetView<SelectAddressMapController> {
  const SelectAddressMapView(
      {this.hideButton = false, required this.isOrigin, super.key});
  final bool isOrigin;
  final bool hideButton;
  @override
  Widget build(BuildContext context) {
    String? result;
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
                      child: Stack(
                        children: [
                          GoogleMap(
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
                            onTap: (pos) {
                              if (isOrigin) {
                                controller.addOriginMarker(pos);
                              } else {
                                controller.addDestanationMarker(pos);
                              }
                            },
                            initialCameraPosition:
                                controller.cameraPosition.value,
                            onMapCreated: controller.onMapCreated,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: SearchMapInput(
                                searchHeight: 75.h,
                                suggestionBoxHeight: 120.h,
                                onSelect: (selectedItem) async {
                                  result =
                                      await controller.onSelectSearchMapInput(
                                    selectedItem: selectedItem,
                                    isOrigin: isOrigin,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
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
      floatingActionButton: hideButton
          ? null
          : AppButton(
              text: el.tr(AppStrings.ok),
              onTap: () => Get.back(result: result),
              color: ColorManger.blackText,
              textStyle:
                  Get.textTheme.bodyLarge!.copyWith(color: ColorManger.white),
              borderRadios: AppSize.s20,
              width: 354.w,
              height: 60.h,
            ),
    );
  }
}
