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
  final MyRequest myRequestController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TimerControllerListener(
      controller: myRequestController.controller,
      listenWhen: (previousValue, currentValue) =>
          previousValue.status != currentValue.status,
      listener: (context, timerValue) {
        print(timerValue.remaining);
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

            return timerValue.remaining == 0
                ? const Text(
                    'No activity',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 25.0),
                  )
                : DelayedFade(
                    delay: 400,
                    child: CircularCountdown(
                      diameter: 155,
                      countdownTotal: timerValue.remaining,
                      countdownCurrentColor: timerColor,
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
