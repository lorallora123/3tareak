import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';

class EmptyPage extends StatelessWidget {
  final String? emptyMessage;

  const EmptyPage({
    Key? key,
    this.emptyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 15),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(ImageAssets.notFound)),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Text(
            emptyMessage ?? AppStrings.screenIsEmpty,
            style: Get.textTheme.labelLarge!.copyWith(fontSize: 23.sp),
          ),
        ],
      ),
    );
  }
}
