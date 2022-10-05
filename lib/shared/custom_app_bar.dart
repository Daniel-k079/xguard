import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:timer_controller/timer_controller.dart';
import 'package:xguard/animations/animations.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/shared/shared.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.borderRadius,
  }) : super(key: key);

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    final MyRequest myRequestController = Get.find();
    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      elevation: 20,
      shadowColor: Colors.black,
      collapsedHeight: 240,
      expandedHeight: 340 + MediaQuery.of(context).padding.top,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 33, 163, 243),
              Color.fromARGB(255, 23, 148, 165),
              Color.fromARGB(255, 134, 91, 227)
            ],
            begin: Alignment.topLeft,
          ),
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(borderRadius)),
        ),
        child: Padding(
            padding: const EdgeInsets.only(
                top: 60.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      const DelayedFade(
                        delay: 200,
                        child: Text(
                          'GuardX',
                          style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: 'Comfortaa',
                              color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            loginController.logout(context);
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                const DelayedFade(
                  delay: 300,
                  child: Text(
                    'Current Time Access',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        color: Colors.white),
                  ),
                ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Countdown(),
                const Spacer(),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: DelayedAnimation(
                    delay: 500,
                    child: Row(
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'CHECKED-IN',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(207, 255, 255, 255)),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Obx(() {
                                return Row(
                                  children: [
                                    const Icon(CupertinoIcons.clock,
                                        color:
                                            Color.fromARGB(218, 210, 199, 244)),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    myRequestController.data.value.isNotEmpty
                                        ? Text(
                                            DateFormat('hh:mm').format(DateTime
                                                .parse(myRequestController
                                                        .data['visit_date'] ??
                                                    '')),
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: 'Poppins',
                                                color: Color.fromARGB(
                                                    218, 210, 199, 244)),
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                );
                              })
                            ],
                          ),
                        ),
                        const Spacer(),
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'CHECKED-OUT',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(207, 255, 255, 255)),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Obx(() {
                                return Row(
                                  children: [
                                    const Icon(CupertinoIcons.clock,
                                        color:
                                            Color.fromARGB(218, 210, 199, 244)),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    myRequestController.data.value.isNotEmpty
                                        ? Text(
                                            DateFormat('hh:mm').format(
                                                DateTime.parse(
                                                        myRequestController
                                                            .data['visit_date'])
                                                    .add(const Duration(
                                                        minutes: 10))),
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: 'Poppins',
                                                color: Color.fromARGB(
                                                    218, 210, 199, 244)),
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                );
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({
    Key? key,
    required this.borderRadius,
  }) : super(key: key);

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      elevation: 20,
      shadowColor: Colors.black,
      collapsedHeight: 90,
      expandedHeight: 100 + MediaQuery.of(context).padding.top,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 69, 150, 200),
              Color.fromARGB(255, 54, 95, 172),
              Color.fromARGB(255, 54, 28, 109)
            ],
            begin: Alignment.topLeft,
          ),
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(borderRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 60.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    const DelayedFade(
                      delay: 200,
                      child: Text(
                        'GuardX',
                        style: TextStyle(
                            fontSize: 19.0,
                            fontFamily: 'Comfortaa',
                            color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          loginController.logout(context);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              DelayedFade(
                  delay: 300,
                  child: Text(
                    'Hello ${GetStorage().read('lecturer_name')}',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        color: Colors.white),
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
