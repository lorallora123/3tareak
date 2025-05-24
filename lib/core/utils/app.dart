import 'package:easy_localization/easy_localization.dart' as el;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/core/utils/theme_manger.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), //1800
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) => SafeArea(
        child: GetMaterialApp(
          title: "عطريقك",
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          useInheritedMediaQuery: true,
          getPages: pages,
          theme: getApplicationTheme,
          initialRoute: AppRoutes.splashRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
