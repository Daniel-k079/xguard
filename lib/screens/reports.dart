import 'package:flutter/material.dart';
import 'package:xguard/screens/screens.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          const TopHeader(
            showSignOutButton: true,
            title: 'Reports', subHeading: 'Reports for admin view'),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: ListView(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 60.0),
              children: <Widget>[
                const Text('Visitor category',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                const Text('Users registered on the system',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.amber[800]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '45',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('Student A',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                  )),
                              Text('Unregular Student',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'Poppins',
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.orange[800]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '212',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('Student B',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                  )),
                              Text('Regular Student',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'Poppins',
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.yellow[800]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('Guest',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                  )),
                              Text('UnCategorized',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'Poppins',
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                const Text('Permission Requests',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                const Text('Showing recent permission categories',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text('Accepted Requests',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                        )),
                    Spacer(),
                    Text('20%',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                        )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AbsorbPointer(
                        child: SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 15.0,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8),
                          ),
                          child: Slider(
                              min: 0,
                              max: 100,
                              value: 2 / 10 * 100,
                              inactiveColor:
                                  const Color.fromARGB(92, 188, 218, 220),
                              activeColor:
                                  const Color.fromARGB(255, 106, 33, 209),
                              onChanged: (value) {}),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text('Declined Requests',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                        )),
                    Spacer(),
                    Text('15%',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                        )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AbsorbPointer(
                        child: SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 15.0,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8),
                          ),
                          child: Slider(
                              min: 0,
                              max: 100,
                              value: 2 / 13 * 100,
                              inactiveColor:
                                  const Color.fromARGB(92, 188, 218, 220),
                              activeColor:
                                  const Color.fromARGB(255, 106, 33, 209),
                              onChanged: (value) {}),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text('Attended Requests',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                        )),
                    Spacer(),
                    Text('75%',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                        )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AbsorbPointer(
                        child: SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 15.0,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8),
                          ),
                          child: Slider(
                              min: 0,
                              max: 100,
                              value: 7 / 10 * 100,
                              inactiveColor:
                                  const Color.fromARGB(92, 188, 218, 220),
                              activeColor:
                                  const Color.fromARGB(255, 106, 33, 209),
                              onChanged: (value) {}),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
