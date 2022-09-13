import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/models/data_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MyRequestController myRequestController = Get.find();
  late var object;


  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    object = null;
var tempList  = await myRequestController.myRequests.stream.first;
    if (tempList.isNotEmpty) {

      object = tempList.firstWhereOrNull((element) =>
          DateTime.parse(element.visitDate!)
                  .difference(DateTime.now())
                  .inMinutes <=
              0 &&
          DateTime.parse(element.visitDate!)
                  .difference(DateTime.now())
                  .inMinutes >=
              -10);

      do {

        print(object);
        await Future.delayed(const Duration(seconds: 4));

        if (object == null) {
          myRequestController.slot(false);
          setState(() {});
        } else {
          myRequestController.slot(true);
          setState(() {});
        }
        object = tempList.firstWhereOrNull((element) =>
            DateTime.parse(element.visitDate!)
                    .difference(DateTime.now())
                    .inMinutes <=
                0 &&
            DateTime.parse(element.visitDate!)
                    .difference(DateTime.now())
                    .inMinutes >=
                -10);

      } while (object == null || object != null);
    } else {
      object = null;
    }
  }

  // @override
  // void dispose() {
  //   tempList = [];
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 308.0, left: 10.0, right: 10.0),
            child: myRequestController.myRequests.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 160.0, bottom: 130),
                    itemCount: myRequestController.myRequests.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Obx(() {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: DateTime.parse(myRequestController
                                          .myRequests[index].visitDate!)
                                      .isAfter(DateTime.now())
                                  ? const Color.fromARGB(255, 101, 156, 210)
                                  : const Color.fromARGB(255, 164, 192, 216),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        myRequestController
                                            .myRequests[index].visitReason!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins'),
                                      ),
                                      const Spacer(),
                                      Text(
                                        DateFormat('MMM dd, yyyy').format(
                                            DateTime.parse(myRequestController
                                                .myRequests[index].visitDate!)),
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Poppins'),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        !DateTime.parse(myRequestController
                                                    .myRequests[index]
                                                    .visitDate!)
                                                .isAfter(DateTime.now())
                                            ? 'Elapsed'
                                            : 'In schedule',
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Poppins'),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Visited COCIS for ${myRequestController.myRequests[index].visitReason} with ${myRequestController.myRequests[index].personToMeet} at ${DateFormat('hh:mm').format(DateTime.parse(myRequestController.myRequests[index].visitDate!))}',
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
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
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
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
                  const Text(
                    'Current Time Access',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      object == null
                          ? const Text(
                              '-- : -- ',
                              style: TextStyle(
                                  fontFamily: 'Shrikhand',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30.0),
                            )
                          : CountdownTimer(
                              myRequestController: myRequestController),
                      const Text(
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
                          Row(
                            children: [
                              const Icon(CupertinoIcons.clock,
                                  color: Color.fromARGB(218, 210, 199, 244)),
                              const SizedBox(
                                width: 10.0,
                              ),
                              object != null
                                  ? Text(
                                      DateFormat('hh:mm').format(
                                          DateTime.parse(object.visitDate)),
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'Poppins',
                                          color: Color.fromARGB(
                                              218, 210, 199, 244)),
                                    )
                                  : Container(),
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
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
                          Row(
                            children: [
                              const Icon(CupertinoIcons.clock,
                                  color: Color.fromARGB(218, 210, 199, 244)),
                              const SizedBox(
                                width: 10.0,
                              ),
                              object != null
                                  ? Text(
                                      DateFormat('hh:mm').format(
                                          DateTime.parse(object.visitDate).add(
                                              const Duration(minutes: 10))),
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'Poppins',
                                          color: Color.fromARGB(
                                              218, 210, 199, 244)),
                                    )
                                  : Container(),
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

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({
    Key? key,
    required this.myRequestController,
  }) : super(key: key);

  final MyRequestController myRequestController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: SlideCountdown(
        
        decoration: const BoxDecoration(),
        duration: myRequestController.accessDuration!,
        textStyle: const TextStyle(
            fontFamily: 'Shrikhand',
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 40.0),
      ),
    );
  }
}
