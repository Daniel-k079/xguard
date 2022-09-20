import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class NavigationController extends GetxController {
  PageController pageController = PageController();
  var currentIndex = 0.obs;

  List navBarItems = [
    {'label': 'Home', 'icon': IcoFontIcons.uiHome},
    {'label': 'Request', 'icon': IcoFontIcons.uiAdd},
    {'label': 'Profile', 'icon': IcoFontIcons.uiUser}
  ];

  void pageSwitcher(int index) {
    currentIndex.value = index;

    switch (index) {
      case 0:
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
        break;
      case 1:
        pageController.animateToPage(1,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
        break;
      case 2:
        pageController.animateToPage(2,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
        break;
      default:
    }
  }
}
