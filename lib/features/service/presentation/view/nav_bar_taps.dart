import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';

Positioned nav_bar_taps(RxInt selectedIndex) {
  return Positioned(
    left: 0,
    right: 0,
    bottom: 0,
    child: Obx(
      () => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex.value,
          onTap: (index) => selectedIndex.value = index,
          backgroundColor: Colors.white,
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'بروفايل',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'رحلة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
          ],
        ),
      ),
    ),
  );
}
