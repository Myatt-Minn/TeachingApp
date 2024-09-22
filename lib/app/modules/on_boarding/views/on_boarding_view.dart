import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen_bottom_navigation_bar.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return GFIntroScreen(
      color: Colors.blueGrey,
      slides: controller.slides(context),
      pageController: controller.pageController,
      currentIndex: controller.initialPage,
      pageCount: 5,
      introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
        pageController: controller.pageController,
        pageCount: controller.slideList.length,
        currentIndex: controller.initialPage,
        onForwardButtonTap: () {
          controller.pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        },
        onBackButtonTap: () {
          controller.pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        },
        onDoneTap: () {
          Get.offAllNamed('/auth-gate');
        },
        onSkipTap: () => Get.offAllNamed('/auth-gate'),
        navigationBarColor: Colors.white,
        showDivider: false,
        // inActiveColor: Colors.grey[200],
        activeColor: GFColors.SUCCESS,
      ),
    );
  }
}
