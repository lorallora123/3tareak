import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoadingListBigItem extends StatelessWidget {
  const LoadingListBigItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
    // return ListView.separated(
    //   itemBuilder: (context, index) => ShimmerWidget.circular(
    //       width: 243.w,
    //       height: 193.h,
    //       shapeBorder: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(AppSize.s30))),
    //   padding: EdgeInsets.only(bottom: 26.h),
    //   separatorBuilder: (context, index) => 26.verticalSpace,
    //   itemCount: 3,
    //   physics: const NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    // );
  }
}
