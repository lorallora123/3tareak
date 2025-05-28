import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer(
      {super.key, required this.height, required this.width, this.raduis});
  final double height;
  final double width;
  final double? raduis;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey[300]!,
      direction: ShimmerDirection.ltr,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(raduis ?? 10))),
    );
  }
}
