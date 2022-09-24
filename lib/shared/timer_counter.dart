import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_controller/timer_controller.dart';
import 'package:xguard/animations/delay_fade.dart';

import '../controllers/my_requests.dart';

class Countdown extends StatefulWidget {
  const Countdown({
    Key? key,
  }) : super(key: key);

  @override
  CountdownState createState() => CountdownState();
}

class CountdownState extends State<Countdown> {
  final instantiate myRequestController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TimerControllerListener(
      controller: myRequestController.controller,
      listenWhen: (previousValue, currentValue) =>
          previousValue.status != currentValue.status,
      listener: (context, timerValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          _StatusSnackBar(
            'Status: ${describeEnum(timerValue.status)}',
          ),
        );
      },
      child: Expanded(
        child: TimerControllerBuilder(
          controller: myRequestController.controller,
          builder: (context, timerValue, _) {
            Color? timerColor;
            switch (timerValue.status) {
              case TimerStatus.running:
                timerColor = const Color.fromARGB(255, 44, 44, 159);
                break;
              case TimerStatus.paused:
                timerColor = Colors.grey;
                break;
              case TimerStatus.finished:
                timerColor = Colors.red;
                break;
              default:
            }

            return DelayedFade(
              delay: 400,
              child: CircularCountdown(
                diameter: 140,
                countdownTotal:
                    myRequestController.controller.initialValue.remaining,
                countdownRemaining: timerValue.remaining,
                countdownCurrentColor: timerColor,
                // countdownRemainingColor:
                //     const Color.fromARGB(132, 111, 174, 213),
                // countdownTotalColor: const Color.fromARGB(0, 230, 225, 225),
                textStyle: const TextStyle(
                  fontFamily: 'Shrikhand',
                  color: Color.fromARGB(227, 228, 246, 255),
                  fontSize: 60,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StatusSnackBar extends SnackBar {
  _StatusSnackBar(
    String title,
  ) : super(
          content: Text(title),
          duration: const Duration(seconds: 1),
        );
}
