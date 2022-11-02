import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xguard/animations/delayed_animation.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/screens/reports.dart';
import 'package:xguard/shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  double borderRadius = 45.0;

  void scrollListener() {
    ScrollDirection scrollDirection =
        scrollController.position.userScrollDirection;

    if (scrollDirection == ScrollDirection.forward) {
      setState(() {
        borderRadius = 45.0;
      });
    } else if (scrollDirection == ScrollDirection.reverse) {
      setState(() {
        borderRadius = 0.0;
      });
    }
  }

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myRequestController = Get.put(MyRequest());
    return Obx(() {
      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        cacheExtent: 0,
        slivers: [
          CustomAppBar(borderRadius: borderRadius),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: myRequestController.myRequests.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 40.0,
                          ),
                          Text(
                            'No pass gates',
                            style: TextStyle(
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
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 20.0, bottom: 130),
                        itemCount: myRequestController.myRequests.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: DelayedAnimation(
                                delay: 230 * index,
                                child: Obx(() {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: DateTime.parse(
                                                    myRequestController
                                                        .myRequests[index]
                                                        .visitDate!)
                                                .isAfter(DateTime.now())
                                            ? Color.fromARGB(255, 142, 93, 221)
                                            : const Color.fromARGB(
                                                255, 164, 192, 216)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Colors.white24),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    myRequestController
                                                                .myRequests[
                                                                    index]
                                                                .permitted ==
                                                            0
                                                        ? 'Pending'
                                                        : myRequestController
                                                                    .myRequests[
                                                                        index]
                                                                    .permitted ==
                                                                1
                                                            ? 'Accepted'
                                                            : 'Declined',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Colors.white24),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        myRequestController
                                                                        .myRequests[
                                                                            index]
                                                                        .permitted ==
                                                                    0 &&
                                                                !DateTime.parse(myRequestController
                                                                        .myRequests[
                                                                            index]
                                                                        .visitDate!)
                                                                    .isAfter(
                                                                        DateTime
                                                                            .now())
                                                            ? 'Failed to schedule'
                                                            : !DateTime.parse(myRequestController.myRequests[index].visitDate!).isAfter(DateTime.now()) &&
                                                                    myRequestController
                                                                            .myRequests[
                                                                                index]
                                                                            .permitted ==
                                                                        1
                                                                ? 'Accepted, Elapsed'
                                                                : !DateTime.parse(myRequestController.myRequests[index].visitDate!)
                                                                            .isAfter(DateTime.now()) &&
                                                                        myRequestController.myRequests[index].permitted == 1
                                                                    ? 'Pending, In schedule'
                                                                    : '',
                                                        style: const TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Poppins'),
                                                      ),
                                                      Icon(
                                                        myRequestController
                                                                        .myRequests[
                                                                            index]
                                                                        .permitted ==
                                                                    0 &&
                                                                !DateTime.parse(myRequestController
                                                                        .myRequests[
                                                                            index]
                                                                        .visitDate!)
                                                                    .isAfter(
                                                                        DateTime
                                                                            .now())
                                                            ? CupertinoIcons
                                                                .multiply
                                                            : DateTime.parse(myRequestController
                                                                        .myRequests[
                                                                            index]
                                                                        .visitDate!)
                                                                    .isAfter(
                                                                        DateTime
                                                                            .now())
                                                                ? CupertinoIcons
                                                                    .clock
                                                                : CupertinoIcons
                                                                    .check_mark,
                                                        size: 17.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4.0,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            myRequestController
                                                .myRequests[index].visitReason!,
                                            style: const TextStyle(
                                                fontSize: 23.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins'),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            'Visited COCIS for ${myRequestController.myRequests[index].visitReason} with ${myRequestController.myRequests[index].personToMeet} at ${DateFormat('hh:mm').format(DateTime.parse(myRequestController.myRequests[index].visitDate!))} on ${DateFormat('MMM dd, yyyy').format(DateTime.parse(myRequestController.myRequests[index].visitDate!))}',
                                            style: const TextStyle(
                                                fontSize: 17.0,
                                                fontFamily: 'Poppins'),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ));
                        }),
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).padding.bottom + 20,
            ),
          )
        ],
      );
    });
  }
}

class LecturerViewPage extends StatefulWidget {
  const LecturerViewPage({Key? key}) : super(key: key);

  @override
  State<LecturerViewPage> createState() => _LecturerViewPageState();
}

class _LecturerViewPageState extends State<LecturerViewPage> {
  final myRequestController = Get.put(MyRequest());
  final ScrollController scrollController = ScrollController();
  var userUid = FirebaseAuth.instance.currentUser!.uid;

  double borderRadius = 45.0;

  void scrollListener() {
    ScrollDirection scrollDirection =
        scrollController.position.userScrollDirection;

    if (scrollDirection == ScrollDirection.forward) {
      setState(() {
        borderRadius = 45.0;
      });
    } else if (scrollDirection == ScrollDirection.reverse) {
      setState(() {
        borderRadius = 0.0;
      });
    }
  }

  @override
  void initState() {
    scrollController.addListener(scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(NavigationController());
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: navController.pageController,
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  cacheExtent: 0,
                  slivers: [
                    CustomAppBar2(
                      borderRadius: borderRadius,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: myRequestController.myRequestsLec.isEmpty
                              ? Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 40.0,
                                    ),
                                    Text(
                                      'No appointments',
                                      style: TextStyle(
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Your recent appointments will appear here',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ],
                                ))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 130),
                                  itemCount:
                                      myRequestController.myRequestsLec.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: DelayedAnimation(
                                          delay: 230 * index,
                                          child: Obx(() {
                                            return Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: myRequestController
                                                              .myRequestsLec[
                                                                  index]
                                                              .visitReason ==
                                                          'Appointment Request'
                                                      ? const Color.fromARGB(
                                                          255, 164, 192, 216)
                                                      : DateTime.parse(myRequestController.myRequestsLec[index].visitDate!)
                                                              .isAfter(DateTime
                                                                  .now())
                                                          ? const Color.fromARGB(
                                                              255, 199, 179, 231)
                                                          : const Color.fromARGB(
                                                              255,
                                                              164,
                                                              192,
                                                              216)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Spacer(),
                                                        myRequestController
                                                                    .myRequestsLec[
                                                                        index]
                                                                    .visitReason ==
                                                                'Appointment Request'
                                                            ? const SizedBox.shrink()
                                                            : Text(
                                                                !DateTime.parse(myRequestController
                                                                            .myRequestsLec[
                                                                                index]
                                                                            .visitDate!)
                                                                        .isAfter(
                                                                            DateTime.now())
                                                                    ? 'Elapsed'
                                                                    : 'In schedule',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontFamily:
                                                                        'Poppins'),
                                                              ),
                                                        const SizedBox(
                                                          width: 4.0,
                                                        ),
                                                        myRequestController
                                                                    .myRequestsLec[
                                                                        index]
                                                                    .visitReason ==
                                                                'Appointment Request'
                                                            ? SizedBox.shrink()
                                                            : Icon(
                                                                DateTime.parse(myRequestController
                                                                            .myRequestsLec[
                                                                                index]
                                                                            .visitDate!)
                                                                        .isAfter(DateTime
                                                                            .now())
                                                                    ? CupertinoIcons
                                                                        .clock
                                                                    : CupertinoIcons
                                                                        .check_mark,
                                                                size: 17.0,
                                                              ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      myRequestController
                                                          .myRequestsLec[index]
                                                          .visitReason!,
                                                      style: const TextStyle(
                                                          fontSize: 23.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      myRequestController
                                                                  .myRequestsLec[
                                                                      index]
                                                                  .visitReason ==
                                                              'Appointment Request'
                                                          ? 'You have an Appointment with a student whose student number is ${myRequestController.myRequestsLec[index].studentName}, they booked using USSD at ${myRequestController.myRequestsLec[index].visitDate}'
                                                          : 'You will have an appointment for ${myRequestController.myRequestsLec[index].visitReason} with ${myRequestController.myRequestsLec[index].studentName ?? ''} at  ${DateFormat('hh:mm').format(DateTime.parse(myRequestController.myRequestsLec[index].visitDate!))} on ${DateFormat('MMM dd, yyyy').format(DateTime.parse(myRequestController.myRequestsLec[index].visitDate!))}',
                                                      style: const TextStyle(
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    myRequestController
                                                                .myRequestsLec[
                                                                    index]
                                                                .visitReason ==
                                                            'Appointment Request'
                                                        ? const SizedBox.shrink()
                                                        : myRequestController
                                                                    .myRequestsLec[
                                                                        index]
                                                                    .permitted !=
                                                                0
                                                            ? const SizedBox
                                                                .shrink()
                                                            : Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: ElevatedButton(
                                                                          onPressed: () {
                                                                            showCupertinoModalPopup(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return CupertinoActionSheet(
                                                                                    title: const Text(
                                                                                      'Make Decision',
                                                                                      style: TextStyle(fontSize: 17.0, color: Colors.black, fontFamily: 'Poppins'),
                                                                                    ),
                                                                                    message: const Text(
                                                                                      'Approve/Decline request for this meeting. Nite this action cannot be reversed',
                                                                                      style: TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'Poppins'),
                                                                                    ),
                                                                                    actions: [
                                                                                      CupertinoActionSheetAction(
                                                                                          isDefaultAction: true,
                                                                                          onPressed: () {
                                                                                            FirebaseFirestore.instance.doc(myRequestController.myRequestsLec[index].userID!).update({
                                                                                              'permitted': 1
                                                                                            });
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: const Text(
                                                                                            'Accept',
                                                                                            style: TextStyle(fontSize: 17.0, color: Colors.green, fontFamily: 'Poppins'),
                                                                                          )),
                                                                                      CupertinoActionSheetAction(
                                                                                          onPressed: () {
                                                                                            FirebaseFirestore.instance.doc(myRequestController.myRequestsLec[index].userID!).update({
                                                                                              'permitted': 2
                                                                                            });
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: const Text(
                                                                                            'Decline',
                                                                                            style: TextStyle(fontSize: 17.0, color: Colors.grey, fontFamily: 'Poppins'),
                                                                                          ))
                                                                                    ],
                                                                                    cancelButton: CupertinoActionSheetAction(
                                                                                        isDestructiveAction: true,
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: const Text(
                                                                                          'Cancel',
                                                                                          style: TextStyle(fontSize: 15.0, color: Colors.red, fontFamily: 'Poppins'),
                                                                                        )),
                                                                                  );
                                                                                });
                                                                          },
                                                                          child: const Text(
                                                                            'Make Decision',
                                                                            style:
                                                                                TextStyle(fontFamily: 'Poppins'),
                                                                          ))),
                                                                ],
                                                              ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ));
                                  }),
                        ),
                      ]),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
            // NavBar(navController: navController)
          ],
        ),
      );
    });
  }
}
