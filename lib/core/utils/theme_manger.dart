import 'package:flutter/material.dart';

import 'color_manger.dart';
import 'font_manger.dart';
import 'styles_manger.dart';
import 'values_manger.dart';

final getApplicationTheme = ThemeData(
  primaryColor: ColorManger.primary,
  disabledColor: ColorManger.greyColor,
  unselectedWidgetColor: ColorManger.greyColor,
  useMaterial3: true,

  cardTheme: const CardThemeData(
      color: ColorManger.white,
      shadowColor: ColorManger.greyColor,
      elevation: AppSize.s4),

  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     elevation: AppSize.s10,
  //     type: BottomNavigationBarType.fixed,
  //     selectedLabelStyle:
  //         getBoldStyle(color: ColorManger.purple, fontSize: FontSize.s16),
  //     unselectedLabelStyle:
  //         getRegularStyle(color: ColorManger.grey, fontSize: FontSize.s14),
  //     selectedItemColor: ColorManger.purple,
  //     unselectedItemColor: ColorManger.grey),

  appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManger.white,
      elevation: AppSize.s0,
      shadowColor: ColorManger.greyColor,
      scrolledUnderElevation: 0,
      titleTextStyle:
          getMediumStyle(color: ColorManger.blackText, fontSize: FontSize.s20),
      actionsIconTheme:
          const IconThemeData(color: ColorManger.blackText, size: AppSize.s28)),

  scaffoldBackgroundColor: ColorManger.white,

  tabBarTheme: const TabBarThemeData(dividerColor: ColorManger.white),

  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorManger.primary,
      selectionHandleColor: ColorManger.primary),

  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: ColorManger.blackText,
  ),

  buttonTheme: const ButtonThemeData(
    shape: StadiumBorder(),
    disabledColor: ColorManger.greyColor,
    buttonColor: ColorManger.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle:
              getBoldStyle(color: ColorManger.white, fontSize: FontSize.s18),
          backgroundColor: ColorManger.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12)))),

  textTheme: TextTheme(
    bodySmall: getLightStyle(color: ColorManger.white, fontSize: FontSize.s12),
    bodyMedium:
        getRegularStyle(color: ColorManger.white, fontSize: FontSize.s16),
    bodyLarge: getBoldStyle(color: ColorManger.white, fontSize: FontSize.s20),
    titleSmall:
        getLightStyle(color: ColorManger.blackText, fontSize: FontSize.s12),
    titleMedium:
        getRegularStyle(color: ColorManger.blackText, fontSize: FontSize.s16),
    titleLarge:
        getBoldStyle(color: ColorManger.blackText, fontSize: FontSize.s20),
    displaySmall:
        getLightStyle(color: ColorManger.primary, fontSize: FontSize.s12),
    displayMedium:
        getRegularStyle(color: ColorManger.primary, fontSize: FontSize.s16),
    displayLarge:
        getBoldStyle(color: ColorManger.primary, fontSize: FontSize.s20),
    headlineSmall:
        getLightStyle(color: ColorManger.textGrueColor, fontSize: FontSize.s12),
    headlineMedium: getRegularStyle(
        color: ColorManger.textGrueColor, fontSize: FontSize.s16),
    headlineLarge:
        getBoldStyle(color: ColorManger.textGrueColor, fontSize: FontSize.s20),
    labelSmall:
        getLightStyle(color: ColorManger.textGrueColor, fontSize: FontSize.s12),
    labelMedium: getRegularStyle(
        color: ColorManger.textGrueColor, fontSize: FontSize.s16),
    labelLarge:
        getBoldStyle(color: ColorManger.textGrueColor, fontSize: FontSize.s20),
  ),

  inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularStyle(color: ColorManger.blackText, fontSize: FontSize.s18),
      errorStyle: getRegularStyle(color: ColorManger.errorColor),
      enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManger.borderGreyColor, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8)),
      focusedBorder: UnderlineInputBorder(
          borderSide:
              const BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8)),
      errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManger.errorColor, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8)),
      focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManger.errorColor, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8))),
);

getBoxShadow() {
  return [
    BoxShadow(blurRadius: 16, color: ColorManger.black.withOpacity(0.12))
  ];
}
