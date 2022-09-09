import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:xguard/models/models.dart';

class MyRequestController extends GetxController {
  late Timer timer;
  var currentTimeSlot = false.obs;
  var myRequests = <MyRequestModel>[].obs;
  var userUid = FirebaseAuth.instance.currentUser!.uid;
  var gatePassRequestStream = Stream;
  Duration? accessDuration;

  @override
  void onInit() {
    accessDuration = const Duration(minutes: 10);
    timer = Timer.periodic(const Duration(minutes: 10), ((timer) {}));
    myRequests.bindStream(dataStream());

    super.onInit();
  }

  Stream<List<MyRequestModel>> dataStream() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('requests')
        .doc(userUid)
        .collection('my_passes')
        .snapshots();

    return stream.map((qShot) => qShot.docs
        .map((doc) => MyRequestModel(
              personToMeet: doc['person_to_meet'] ?? '',
              visitDate: doc['visit_date'],
              visitReason: doc['visit_reason'],
            ))
        .toList());
  }
}
