import 'package:flutter/material.dart';

import 'color_manger.dart';
import 'font_manger.dart';
import 'styles_manger.dart';
import 'values_manger.dart';

final getApplicationTheme = ThemeData(
  primaryColor: ColorManager.primary,
  disabledColor: ColorManager.greyColor,
  unselectedWidgetColor: ColorManager.greyColor,
  useMaterial3: true,

  cardTheme: const CardThemeData(
      color: ColorManager.white,
      shadowColor: ColorManager.greyColor,
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
      color: ColorManager.white,
      elevation: AppSize.s0,
      shadowColor: ColorManager.greyColor,
      scrolledUnderElevation: 0,
      titleTextStyle:
          getMediumStyle(color: ColorManager.blackText, fontSize: FontSize.s20),
      actionsIconTheme: const IconThemeData(
          color: ColorManager.blackText, size: AppSize.s28)),

  scaffoldBackgroundColor: ColorManager.white,

  tabBarTheme: const TabBarThemeData(dividerColor: ColorManager.white),

  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorManager.primary,
      selectionHandleColor: ColorManager.primary),

  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: ColorManager.blackText,
  ),

  buttonTheme: const ButtonThemeData(
    shape: StadiumBorder(),
    disabledColor: ColorManager.greyColor,
    buttonColor: ColorManager.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle:
              getBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12)))),

  textTheme: TextTheme(
    bodySmall: getLightStyle(color: ColorManager.white, fontSize: FontSize.s12),
    bodyMedium:
        getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
    bodyLarge: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s20),
    titleSmall:
        getLightStyle(color: ColorManager.blackText, fontSize: FontSize.s12),
    titleMedium:
        getRegularStyle(color: ColorManager.blackText, fontSize: FontSize.s16),
    titleLarge:
        getBoldStyle(color: ColorManager.blackText, fontSize: FontSize.s20),
    displaySmall:
        getLightStyle(color: ColorManager.primary, fontSize: FontSize.s12),
    displayMedium:
        getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16),
    displayLarge:
        getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s20),
    headlineSmall: getLightStyle(
        color: ColorManager.textGrueColor, fontSize: FontSize.s12),
    headlineMedium: getRegularStyle(
        color: ColorManager.textGrueColor, fontSize: FontSize.s16),
    headlineLarge:
        getBoldStyle(color: ColorManager.textGrueColor, fontSize: FontSize.s20),
    labelSmall: getLightStyle(
        color: ColorManager.textGrueColor, fontSize: FontSize.s12),
    labelMedium: getRegularStyle(
        color: ColorManager.textGrueColor, fontSize: FontSize.s16),
    labelLarge:
        getBoldStyle(color: ColorManager.textGrueColor, fontSize: FontSize.s20),
  ),

  inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
          color: ColorManager.blackText, fontSize: FontSize.s18),
      errorStyle: getRegularStyle(color: ColorManager.errorColor),
      enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManager.borderGreyColor, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8)),
      focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8)),
      errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManager.errorColor, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8)),
      focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManager.errorColor, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8))),
);

getBoxShadow() {
  return [
    BoxShadow(blurRadius: 16, color: ColorManager.black.withOpacity(0.12))
  ];
}
