import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  var userUid = FirebaseAuth.instance.currentUser!.uid;
  Stream<QuerySnapshot>? userStream;
  Duration? accessDuration;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(minutes: 10), ((timer) {}));

    accessDuration = Duration(minutes: 10);
    userStream = FirebaseFirestore.instance
        .collection('requests')
        .doc(userUid)
        .collection('my_passes')
        .snapshots();
    super.initState();
  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: userStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data!.docs.isNotEmpty) {
            data = snapshot.data?.docs;

            var record;

            data.forEach((value) {
              record =
                  DateTime.parse(value['visit_date']).isBefore(DateTime.now())
                      ? value
                      : '';
              print(value['visit_date']);
            });

            print('here');
            print(record);
          }

          return Stack(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 308.0, left: 10.0, right: 10.0),
                child: data == null
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No pass gates',
                            style: const TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Tap the \'Request +\' button below to add a new gate pass request',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ))
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 160.0, bottom: 130),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color:    DateTime.parse(
                                                      data[index]['visit_date'])
                                                  .isAfter(DateTime.now()) ? Color.fromARGB(255, 101, 156, 210): Color.fromARGB(255, 164, 192, 216),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          data[index]['visit_reason'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins'),
                                        ),
                                        const Spacer(),
                                        Text(
                                          DateFormat('MMM dd, yyyy').format(
                                              DateTime.parse(
                                                  data[index]['visit_date'])),
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: 'Poppins'),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          !DateTime.parse(
                                                      data[index]['visit_date'])
                                                  .isAfter(DateTime.now())
                                              ? 'Elapsed'
                                              : 'In schedule',
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: 'Poppins'),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Visited COCIS for ${data[index]['visit_reason']} with ${data[index]['person_to_meet']} at ${DateFormat('hh:mm').format(DateTime.parse(data[index]['visit_date']))}',
                                      style: TextStyle(fontFamily: 'Poppins'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.49,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 33, 163, 243),
                        Color.fromARGB(255, 23, 148, 165),
                        Color.fromARGB(255, 134, 91, 227)
                      ],
                      begin: Alignment.topLeft,
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(60.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'GuardX',
                            style: TextStyle(
                                fontSize: 19.0,
                                fontFamily: 'Comfortaa',
                                color: Colors.white),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.info, color: Colors.white))
                        ],
                      ),
                      const Spacer(),
                      Text(
                        'Current Time Access',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                            color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          data == null
                              ? Text(
                                  '-- : -- ',
                                  style: TextStyle(
                                      fontFamily: 'Shrikhand',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30.0),
                                )
                              : SizedBox(
                                  width: 190,
                                  child: SlideCountdown(
                                    decoration: BoxDecoration(),
                                    duration: accessDuration!,
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
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(207, 255, 255, 255)),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Icon(CupertinoIcons.clock,
                                      color:
                                          Color.fromARGB(218, 210, 199, 244)),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '10:00AM',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins',
                                        color:
                                            Color.fromARGB(218, 210, 199, 244)),
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
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(207, 255, 255, 255)),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Icon(CupertinoIcons.clock,
                                      color:
                                          Color.fromARGB(218, 210, 199, 244)),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '10:10AM',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins',
                                        color:
                                            Color.fromARGB(218, 210, 199, 244)),
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
        });
  }
}
