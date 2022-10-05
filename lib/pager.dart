import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/shared/shared.dart';
import 'screens/screens.dart';

class Pager extends StatefulWidget {
  /// Pager class
  /// Here we are creating our [Pager] class
  /// This is like our main canvas on which we paint and draw pages and then put it up on the wall
  ///  [MyApp] for this case.
  const Pager({Key? key}) : super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  /// Here we are injecting our dependencies
  final navController = Get.put(NavigationController());
  final myRequestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        PageView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          controller: navController.pageController,
          children: const <Widget>[
            HomePage(),
            Request(),
            Profile(),
          ],
        ),
        NavBar(navController: navController)
      ]),
    );
  }
}
