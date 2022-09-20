import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timer_controller/timer_controller.dart';
import 'package:xguard/models/models.dart';

import 'request_controller.dart';

class MyRequestController extends GetxController {
  late final TimerController controller;
  var myRequests = <MyRequestModel>[].obs;
  var myRequestsLec = <MyRequestModel>[].obs;
  var userUid = FirebaseAuth.instance.currentUser!.uid;
  var slot = false.obs;
  var color = const Color.fromARGB(255, 164, 192, 216).obs;
  late Rx<MyRequestModel?> object = MyRequestModel().obs;
  late Rx<MyRequestModel?> objectLec = MyRequestModel().obs;

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
            ))
        .toList());
  }

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
            ))
        .toList());
  }

  @override
  void onInit() async {
    controller = TimerController.minutes(10);
    myRequests.bindStream(dataStream());
    myRequestsLec.bindStream(lecturerDataStream());

    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      await getLecturerData();
    } else {
      await getData();
    }

    super.onInit();
  }

  Future<void> getLecturerData() async {
    objectLec.value = MyRequestModel();
    var tempList = await myRequestsLec.stream.first;

    object.value = tempList.firstWhereOrNull((element) =>
        DateTime.parse(element.visitDate!)
                .difference(DateTime.now())
                .inMinutes <=
            0 &&
        DateTime.parse(element.visitDate!)
                .difference(DateTime.now())
                .inMinutes >=
            -10);

    while (objectLec.value == null || objectLec.value != null) {
      await Future.delayed(const Duration(seconds: 4));
      print(objectLec.value);

      if (objectLec.value == null) {
        slot(false);
      } else {
        slot(true);
        controller.start();
      }
      objectLec.value = tempList.firstWhereOrNull((element) =>
          DateTime.parse(element.visitDate!)
                  .difference(DateTime.now())
                  .inMinutes <=
              0 &&
          DateTime.parse(element.visitDate!)
                  .difference(DateTime.now())
                  .inMinutes >=
              -10);
    }
  }

  Future<void> getData() async {
    object.value = MyRequestModel();
    var tempList = await myRequests.stream.first;

    object.value = tempList.firstWhereOrNull((element) =>
        DateTime.parse(element.visitDate!)
                .difference(DateTime.now())
                .inMinutes <=
            0 &&
        DateTime.parse(element.visitDate!)
                .difference(DateTime.now())
                .inMinutes >=
            -10);

    while (object.value == null || object.value != null) {
      await Future.delayed(const Duration(seconds: 4));
      print(object.value);

      if (object.value == null) {
        slot(false);
      } else {
        slot(true);
        controller.start();
      }
      object.value = tempList.firstWhereOrNull((element) =>
          DateTime.parse(element.visitDate!)
                  .difference(DateTime.now())
                  .inMinutes <=
              0 &&
          DateTime.parse(element.visitDate!)
                  .difference(DateTime.now())
                  .inMinutes >=
              -10);
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
