import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_controller/timer_controller.dart';
import 'package:xguard/models/models.dart';
import 'request_controller.dart';

class MyRequest extends GetxController {
  late final TimerController controller;
  var myRequests = <MyRequestModel>[].obs;
  var myRequestsLec = <MyRequestModel>[].obs;
  var userUid = FirebaseAuth.instance.currentUser!.uid;
  var slot = false.obs;
  var color = const Color.fromARGB(255, 164, 192, 216).obs;
  late Rx<MyRequestModel?> objectLec = MyRequestModel().obs;
  late RxMap data = {}.obs;

  testCase() async {
    myRequests.bindStream(dataStream());
    FirebaseFirestore.instance
        .collection('requests')
        .doc(userUid)
        .collection('my_passes')
        .snapshots()
        .listen((event) async {
      while (event.docs.isNotEmpty) {
        await Future.delayed(Duration.zero);

        data.value = event.docs.firstWhereOrNull((element) {
              return DateTime.parse(element['visit_date'])
                          .difference(DateTime.now())
                          .inMinutes <=
                      0 &&
                  DateTime.parse(element['visit_date'])
                          .difference(DateTime.now())
                          .inMinutes >=
                      -9;
            })?.data() ??
            {};

        if (data.isNotEmpty) {
          slot(true);

          controller.start();
        } else {}
      }
    });
  }

  /// instantiate a stream which listens for changes on the FIrebase [my_passes] collection and maps them to [MyRequest] model
  Stream<List<MyRequestModel>> dataStream() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('requests')
        .doc(userUid)
        .collection('my_passes')
        .snapshots();

    return stream.map((qShot) => qShot.docs
        .map((doc) => MyRequestModel(
            personToMeet: doc['person_to_meet'],
            visitDate: doc['visit_date'],
            visitReason: doc['visit_reason'],
            studentName: doc['student_name']))
        .toList());
  }

  /// instantiate a lecturer stream which listens for changes on the FIrebase [my_passes] collection and query where `/person_to_meet/` is equal to hhe name of the lecturer and maps them to [MyRequest] model
  Stream<List<MyRequestModel>> lecturerDataStream() {
    final requestController = Get.put(RequestController());
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collectionGroup('my_passes')
        .where('person_to_meet',
            whereIn: [requestController.tempLecturer.value]).snapshots();

    return stream.map((qShot) => qShot.docs
        .map((doc) => MyRequestModel(
            personToMeet: doc['person_to_meet'],
            visitDate: doc['visit_date'],
            visitReason: doc['visit_reason'],
            studentName: doc['student_name']))
        .toList());
  }

  @override
  void onInit() async {
    // init the timer counter controller to 10 mins
    controller = TimerController.minutes(10);

    bool isLecturer = FirebaseAuth.instance.currentUser!.isAnonymous;

    if (isLecturer) {
      //bind the data models to the list
      myRequestsLec.bindStream(lecturerDataStream());
    } else {
      testCase();
    }

    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
