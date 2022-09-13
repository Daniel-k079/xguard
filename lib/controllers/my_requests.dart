import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:xguard/models/models.dart';

class MyRequestController extends GetxController {
  late Timer timer;
  Duration? accessDuration;

  var myRequests = <MyRequestModel>[].obs;
  var userUid = FirebaseAuth.instance.currentUser!.uid;
  var gatePassRequestStream = Stream;
  var currentSlot = ''.obs;
  var slot = false.obs;
  var timeElapsed = false.obs;

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

  Future<bool> hasTimeElapsed(int index) async {
    var tempList = await myRequests.stream.first;
    timeElapsed.value =
        !DateTime.parse(tempList[index].visitDate!).isAfter(DateTime.now());

    return timeElapsed.value;
  }

  @override
  void onInit() async {
    accessDuration = const Duration(minutes: 10);
    timer = Timer.periodic(const Duration(minutes: 10), ((timer) {}));
    myRequests.bindStream(dataStream());

    super.onInit();
  }
}
