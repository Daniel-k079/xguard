import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xguard/animations/animations.dart';
import 'package:xguard/controllers/controller.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.navController,
  }) : super(key: key);

  final NavigationController navController;

  @override
  Widget build(BuildContext context) {
    List navIconList = FirebaseAuth.instance.currentUser!.isAnonymous
        ? navController.navBarItems.sublist(4, 6)
        : navController.navBarItems.sublist(0, 4);

    
    return Align(
      alignment: Alignment.bottomCenter,
      child: DelayedFade(
        delay: 650,
        child: Container(
            height: 80.0,
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navIconList
                  .map((item) => BouncingWidget(
                        onPressed: () {
                          navController.pageSwitcher(
                            navIconList.indexOf(item),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                item['icon'],
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                item['label'],
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            )),
      ),
    );
  }
}
