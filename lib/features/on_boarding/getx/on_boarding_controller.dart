import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/routes_manger.dart';
import 'package:take_me_with_you/features/on_boarding/widget/page_one.dart';
import 'package:take_me_with_you/features/on_boarding/widget/page_three.dart';
import 'package:take_me_with_you/features/on_boarding/widget/page_two.dart';
 
class OnBoardingController extends GetxController {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final PageController pageController = PageController();
  final RxInt _pageIndex = 0.obs;
  final RxInt _percent = 1.obs;
  final RxBool _endPage = false.obs;

  int get pageIndex => _pageIndex.value;

  int get percent => _percent.value;

  bool get endPage => _endPage.value;

  set pageIndex(value) => _pageIndex.value = value;

  set percent(value) => _percent.value = value;

  set endPage(value) => _endPage.value = value;

  List<Widget> pages = [const PageOne(), const PageTwo(), const PageThree()];

  onPageChanged(int index) {
    pageIndex = index;
    percent = index + 1;
  }

  onAnimationEnd() {
    if (percent == 3) {
      endPage = true;
    } else {
      endPage = false;
    }
  }

  onTapNextButton() async {
    if (pageIndex == 2) {
      Get.offAllNamed(AppRoutes.loginRoute);
      await _appPreferences.setOnBoarding();
    } else {
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    }
  }

  onTapBackButton() {
    pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  onTapSkipButton() async {
    Get.offAllNamed(AppRoutes.loginRoute);
    await _appPreferences.setOnBoarding();
  }
}
