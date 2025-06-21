import 'dart:math';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lottie/lottie.dart';
import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'package:take_me_with_you/imports.dart';

class CustomSpinWheel extends StatefulWidget {
  const CustomSpinWheel({super.key});

  @override
  CustomSpinWheelState createState() => CustomSpinWheelState();
}

class CustomSpinWheelState extends State<CustomSpinWheel> {
  late final StreamController<int> _controller = StreamController<int>();

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  int randomIndex = -1;
  void selectRandomItem() {
    double totalProbability = probabilities.reduce((a, b) => a + b);
    double randomNumber = Random().nextDouble() * totalProbability;
    double currentProbability = 0.0;
    for (int i = 0; i < probabilities.length; i++) {
      currentProbability += probabilities[i];
      if (randomNumber <= currentProbability) {
        randomIndex = i;
        _controller.add(i);
        break;
      }
    }
  }

  List<double> probabilities = [
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
  ];
  List<String> list = [
    'https://freepngimg.com/thumb/emoji/4-2-smiling-face-with-sunglasses-cool-emoji-png-thumb.png',
    'https://freepngimg.com/thumb/emoji/5-2-face-with-tears-of-joy-emoji-png-thumb.png',
    'https://freepngimg.com/thumb/emoji/3-2-love-hearts-eyes-emoji-png-thumb.png',
    'https://freepngimg.com/thumb/emoji/47426-8-smiley-hd-free-transparent-image-hd-thumb.png',
    'https://freepngimg.com/thumb/emoji/6-2-angel-blushing-smile-emoji-png-thumb.png',
    'https://freepngimg.com/thumb/emoji/11-2-loudly-crying-emoji-png-thumb.png',
    'https://freepngimg.com/thumb/emoji/47426-8-smiley-hd-free-transparent-image-hd-thumb.png',
    'https://freepngimg.com/thumb/emoji/65088-emoticon-piracy-smiley-pirate-emoji-png-image-high-quality-thumb.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Container(
                      margin: EdgeInsets.only(top: 8.h),
                      child: FortuneWheel(
                        selected: _controller.stream,
                        animateFirst: false,
                        duration: const Duration(seconds: 3),
                        physics: CircularPanPhysics(),
                        indicators: const [
                          // FortuneIndicator(
                          //     child:
                          //         TriangleIndicator(color: ColorManger.greyColor),
                          //     alignment: Alignment.topCenter)
                        ],
                        onAnimationEnd: () {
                          Get.dialog(
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0.1.sw, vertical: 0.3.sh),
                                color: Colors.transparent,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    LottieBuilder.asset(
                                      height: double.infinity,
                                      width: double.infinity,
                                      JsonAssets.winImage,
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(32),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              alignment: Alignment.center,
                                              child: CachedNetworkImage(
                                                  imageUrl: list[randomIndex]),
                                            ),
                                          ),
                                          8.verticalSpace,
                                          CustomText(
                                            text: 'لقد فزت !',
                                            style: Get.textTheme.titleLarge!
                                                .copyWith(
                                              color: ColorManager.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              transitionCurve: Curves.bounceIn,
                              transitionDuration: const Duration(seconds: 1));
                        },
                        items: List.generate(
                          list.length,
                          (index) => FortuneItem(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 32.w,
                                right: 8.w,
                                bottom: 16.h,
                                top: 16.h,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: list[index],
                                height: 50.h,
                              ),
                            ),
                            style: FortuneItemStyle(
                                borderWidth: 0.2,
                                color: index % 2 == 0
                                    ? ColorManager.primaryLight
                                    : ColorManager.primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset(ImageAssets.belt),
                ],
              ),
            ),
          ),
          16.verticalSpace,
          AppButton(
            text: el.tr(AppStrings.send),
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorManager.white),
            onTap: () {
              selectRandomItem();
            },
            color: ColorManager.blackText,
            borderRadios: AppSize.s30,
            width: 150.w,
            height: 53.h,
          ),
        ],
      ),
    );
  }
}
