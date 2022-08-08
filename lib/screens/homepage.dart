import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(minutes: 10), ((timer) {}));
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List activities = [
    {
      'title': 'Appointment Request',
      'date': 'Monday, 6th June',
      'activity': 'Visited COCIS for an appointment with Dr Rose at 4:00pm'
    },
    {
      'title': 'Coursework Presentation',
      'date': 'Wednesday, 8th June',
      'activity': 'Coursework presentation with Mr Byansi David at 2:00pm'
    },
    {
      'title': 'Group Discussion',
      'date': 'Thursday, 9th June',
      'activity': 'Group discussion with colleagues'
    },
    {
      'title': 'Final Year Vetting Exercise',
      'date': 'Friday, 10th June',
      'activity': 'Meeting with supervisor Mr Swaib and Dr Rose at 11:00am'
    }
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 208.0, left: 10.0, right: 10.0),
          child: ListWheelScrollView(
              squeeze: 0.9,
              diameterRatio: 3,
              itemExtent: 100,
              children: List.generate(
                activities.length,
                (index) => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(255, 156, 199, 220),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(activities[index]['title'], style: const TextStyle(fontWeight: FontWeight.bold),),
                            const Spacer(),
                            Text(activities[index]['date'], style: const TextStyle(fontSize: 12.0),)
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(activities[index]['activity'])
                      ],
                    ),
                  ),
                ),
              )),
        ),
        Container(
          width: double.infinity,
          height: size.height * 0.49,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(122, 163, 187, 1),
                Color.fromARGB(255, 26, 85, 136)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(60.0))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'GuardX',
                      style: TextStyle(fontSize: 19.0),
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.info))
                  ],
                ),
                const Spacer(),
                Text(
                  'Current Time Access',
                  style: TextStyle(fontSize: 16.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 180,
                      child: SlideCountdown(
                        decoration: BoxDecoration(),
                        duration: Duration(minutes: 10),
                        textStyle: TextStyle(
                            fontFamily: 'Shrikhand',
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 40.0),
                      ),
                    ),
                    Text(
                      'mins',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          // fontWeight: FontWeight.w900,
                          fontSize: 25.0),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'CHECKED-IN',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.clock),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '10:00AM',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: <Widget>[
                        Text(
                          'CHECKED-OUT',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.clock),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '10:10AM',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
