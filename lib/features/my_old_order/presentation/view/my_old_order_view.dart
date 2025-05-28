import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../getx/my_old_order_controller.dart';
import '../widget/my_old_order_app_bar.dart';
import '../widget/my_old_order_list_item.dart';

class MyOldOrdersView extends GetView<MyOldOrdersController> {
  const MyOldOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyOldOrdersAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 19.5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [36.verticalSpace, const MyOldOrdersListItem()],
        ),
      ),
    );
  }
}
