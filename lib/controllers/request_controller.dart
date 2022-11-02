import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xguard/utils/customOverlay.dart';

class RequestController extends GetxController {
  var visitReason = '';
  var personToMeet = '';
  var visitDate = '';
  var tempPassword = ''.obs;
  var tempLecturer = ''.obs;

  TextEditingController unCategorizedVisitor = TextEditingController();

  @override
  onInit() {
    tempLecturer.value = GetStorage().read('lecturer_name');
    super.onInit();
  }

  ///method to add request
  makeRequest() {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    bool isCategorizedVisitor = FirebaseAuth.instance.currentUser!.isAnonymous;

    CustomOverlay.showLoaderOverlay(duration: 3);
    try {
      return FirebaseFirestore.instance
          .collection('requests')
          .doc(userUid)
          .collection('my_passes')
          .doc()
          .set({
        'visit_reason': visitReason,
        'person_to_meet': personToMeet,
        'student_name': isCategorizedVisitor
            ? unCategorizedVisitor.text
            : GetStorage().read('student_names'),
        'visit_date': visitDate,
        'permitted': 0
      });
    } catch (e) {
      CustomOverlay.showToast(
          'Something went wrong, please check your internet connection',
          Colors.orange,
          Colors.white);
    }
  }
}
