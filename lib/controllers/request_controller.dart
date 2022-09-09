import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:xguard/utils/customOverlay.dart';

class RequestController extends GetxController {
  var visitReason = '';
  var personToMeet = '';
  var visitDate = '';

  makeRequest() {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    CustomOverlay.showLoaderOverlay(duration: 3);
    return FirebaseFirestore.instance
        .collection('requests')
        .doc(userUid)
        .collection('my_passes')
        .doc()
        .set({
      'visit_reason': visitReason,
      'person_to_meet': personToMeet,
      'visit_date': visitDate
    });
  }
}
