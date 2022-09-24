import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xguard/animations/delayed_animation.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final instantiate myRequestController = Get.find();
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
    return Obx(() {
      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        cacheExtent: 0,
        slivers: [
          Obx(() {
            return CustomAppBar(
                borderRadius: borderRadius,
                object: myRequestController.object.value);
          }),
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
                                            ? const Color.fromARGB(
                                                255, 22, 119, 203)
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
                                              Text(
                                                !DateTime.parse(
                                                            myRequestController
                                                                .myRequests[
                                                                    index]
                                                                .visitDate!)
                                                        .isAfter(DateTime.now())
                                                    ? 'Elapsed'
                                                    : 'In schedule',
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: 'Poppins'),
                                              ),
                                              const SizedBox(
                                                width: 4.0,
                                              ),
                                              Icon(
                                                DateTime.parse(
                                                            myRequestController
                                                                .myRequests[
                                                                    index]
                                                                .visitDate!)
                                                        .isAfter(DateTime.now())
                                                    ? CupertinoIcons.clock
                                                    : CupertinoIcons.check_mark,
                                                size: 17.0,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                myRequestController
                                                    .myRequests[index]
                                                    .visitReason!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            'Visited COCIS for ${myRequestController.myRequests[index].visitReason} with ${myRequestController.myRequests[index].personToMeet} at ${DateFormat('hh:mm').format(DateTime.parse(myRequestController.myRequests[index].visitDate!))} on ${DateFormat('MMM dd, yyyy').format(DateTime.parse(myRequestController.myRequests[index].visitDate!))}',
                                            style: const TextStyle(
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
  final myRequestController = Get.put(instantiate());
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
    return Obx(() {
      return Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          cacheExtent: 0,
          slivers: [
            Obx(() {
              return CustomAppBar2(
                  borderRadius: borderRadius,
                  object: myRequestController.objectLec.value);
            }),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 130),
                          itemCount: myRequestController.myRequestsLec.length,
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
                                                          .myRequestsLec[index]
                                                          .visitDate!)
                                                  .isAfter(DateTime.now())
                                              ? const Color.fromARGB(
                                                  255, 22, 119, 203)
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
                                                Text(
                                                  !DateTime.parse(
                                                              myRequestController
                                                                  .myRequestsLec[
                                                                      index]
                                                                  .visitDate!)
                                                          .isAfter(
                                                              DateTime.now())
                                                      ? 'Elapsed'
                                                      : 'In schedule',
                                                  style: const TextStyle(
                                                      fontSize: 12.0,
                                                      fontFamily: 'Poppins'),
                                                ),
                                                const SizedBox(
                                                  width: 4.0,
                                                ),
                                                Icon(
                                                  DateTime.parse(
                                                              myRequestController
                                                                  .myRequestsLec[
                                                                      index]
                                                                  .visitDate!)
                                                          .isAfter(
                                                              DateTime.now())
                                                      ? CupertinoIcons.clock
                                                      : CupertinoIcons
                                                          .check_mark,
                                                  size: 17.0,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  myRequestController
                                                      .myRequestsLec[index]
                                                      .visitReason!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Poppins'),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'You will have an appointment for ${myRequestController.myRequestsLec[index].visitReason} at  ${DateFormat('hh:mm').format(DateTime.parse(myRequestController.myRequestsLec[index].visitDate!))} on ${DateFormat('MMM dd, yyyy').format(DateTime.parse(myRequestController.myRequestsLec[index].visitDate!))}',
                                              style: const TextStyle(
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
        ),
      );
    });
  }
}
