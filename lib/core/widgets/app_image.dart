import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';

class AppImage extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final String imageUrl;
  final bool? withBaseUrl;
  final bool? errorLogo;

  const AppImage(
      {super.key,
      required this.imageUrl,
      this.width,
      this.boxFit,
      this.height,
      this.withBaseUrl = true,
      this.errorLogo = true});

  @override
  Widget build(BuildContext context) {
    if ("https://apitareqe.dr-ayman.net/public/storage/" ==
        "${EndPoints.baseImageUrl}/$imageUrl") {
      return SvgPicture.asset(
        IconsAssets.logo,
        height: 75,
        width: 75,
        fit: BoxFit.fill,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl.startsWith("https")
            ? imageUrl
            : "${EndPoints.baseImageUrl}/$imageUrl",
        height: height,
        width: width,
        fit: boxFit,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s20),
                image: DecorationImage(image: imageProvider, fit: boxFit)),
          );
        },
        errorWidget: (context, url, error) {
          if (imageUrl.startsWith("/data/user")) {
            return Image.file(
              File(imageUrl),
              fit: BoxFit.fill,
            );
          } else {
            return errorLogo!
                ? SvgPicture.asset(
                    IconsAssets.logo,
                    width: 75,
                    height: 75,
                    fit: BoxFit.fill,
                  )
                : Image.network("ImageAssets.defaultPicture", fit: boxFit);
          }
        },
        placeholder: (context, url) => Lottie.asset(JsonAssets.loadingImage),
      );
    }
  }
}
