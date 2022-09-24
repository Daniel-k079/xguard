import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_controller/timer_controller.dart';
import 'package:xguard/models/models.dart';
import 'request_controller.dart';

class instantiate extends GetxController {
  late final TimerController controller;
  var myRequests = <MyRequestModel>[].obs;
  var myRequestsLec = <MyRequestModel>[].obs;
  var userUid = FirebaseAuth.instance.currentUser!.uid;
  var slot = false.obs;
  var color = const Color.fromARGB(255, 164, 192, 216).obs;
  late Rx<MyRequestModel?> object = MyRequestModel().obs;
  late Rx<MyRequestModel?> objectLec = MyRequestModel().obs;

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
            ))
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
            ))
        .toList());
  }

  @override
  void onInit() async {
    // init the timer counter controller to 10 mins
    controller = TimerController.minutes(10);

    //bind the data models to the list
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
//here we pick the first object which satisfies the predicate
//we get the time difference between the device time and the
//values in the list object, if the difference in minutes is 0 then
//the event has started and the counter turns on, then
//when the difference in minutes between object element list value amd
//device time is greater or equal to -10 then this means the counter is still active and running
//and will run for that time
    object.value = tempList.firstWhereOrNull((element) =>
        DateTime.parse(element.visitDate!)
                .difference(DateTime.now())
                .inMinutes <=
            0 &&
        DateTime.parse(element.visitDate!)
                .difference(DateTime.now())
                .inMinutes >=
            -10);

//we keep listening whether any element in the list satisfies the condition
    while (objectLec.value == null || objectLec.value != null) {
      await Future.delayed(const Duration(seconds: 4));

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
    //here we pick the first object which satisfies the predicate
    //we get the time difference between the device time and the
    //values in the list object, if the difference in minutes is 0 then
    //the event has started and the counter turns on, then
    //when the difference in minutes between object element list value amd
    //device time is greater or equal to -10 then this means the counter is still active and running
    //and will run for that time

    object.value = tempList.firstWhereOrNull((element) =>
        DateTime.parse(element.visitDate!)
                .difference(DateTime.now())
                .inMinutes <=
            0 &&
        DateTime.parse(element.visitDate!)
                .difference(DateTime.now())
                .inMinutes >=
            -10);

//we keep listening whether any element in the list satisfies the condition
    while (object.value == null || object.value != null) {
      await Future.delayed(const Duration(seconds: 4));

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
