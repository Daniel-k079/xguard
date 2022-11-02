import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class NavigationController extends GetxController {
  PageController pageController = PageController();
  var currentIndex = 0.obs;

  List navBarItems = [
    {'label': 'Home', 'icon': IcoFontIcons.uiHome},
    {'label': 'Scan', 'icon': IcoFontIcons.uiCamera},
    {'label': 'Request', 'icon': IcoFontIcons.uiAdd},
    {'label': 'Profile', 'icon': IcoFontIcons.uiUser},
    {'label': 'Home', 'icon': IcoFontIcons.uiHome},
    
    {'label': 'Reports', 'icon': IcoFontIcons.fileAlt},
  ];

  void pageSwitcher(int index) {
    currentIndex.value = index;
    print(index);

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
      case 3:
        pageController.animateToPage(3,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
        break;
      case 4:
        pageController.animateToPage(4,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
        break;
      case 5:
        pageController.animateToPage(5,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
        break;
      default:
    }
  }
}
