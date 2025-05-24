import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';

final List<String> _items = ['إنشاء رحلة خاصة'];

  void showDropdown(BuildContext context) {
    showMenu(
      color: Colors.white,
      context: context,
      position: const RelativeRect.fromLTRB(0, 0, 100, 0),
      items:
          _items.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
    ).then((value) {
      if (value == 'إنشاء رحلة خاصة') {
        Get.toNamed(AppRoutes.createTripRoute, arguments: {'isPrivate': true});
      }
    });
  }