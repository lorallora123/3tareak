import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            IconsAssets.lightRoadBackground,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
