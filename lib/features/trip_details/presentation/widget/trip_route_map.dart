import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:take_me_with_you/imports.dart';

class TripRouteMap extends GetView<TripDetailsController> {
  const TripRouteMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.4.sh,
      child: GoogleMap(
        mapToolbarEnabled: false,
        myLocationEnabled: true,
        // liteModeEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        polylines: Set<Polyline>.of(controller.polyLines.values),
        //   tiltGesturesEnabled: true,

        markers: {controller.origin.value, controller.destination.value},

        initialCameraPosition:
            CameraPosition(target: controller.tripCameraPosition, zoom: 13),

        onMapCreated: controller.onMapCreated,
      ),
    );
  }
}
