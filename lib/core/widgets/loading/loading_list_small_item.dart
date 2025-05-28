import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/core/utils/values_manger.dart';
import 'package:take_me_with_you/core/widgets/shimmer/shimmer_widget.dart';

class LoadingListSmallItem extends StatelessWidget {
  const LoadingListSmallItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ShimmerWidget.circular(
          width: 243.w,
          height: 70.h,
          shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s30))),
      padding: EdgeInsets.only(bottom: 26.h),
      separatorBuilder: (context, index) => 26.verticalSpace,
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
