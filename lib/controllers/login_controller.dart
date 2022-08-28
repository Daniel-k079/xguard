import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xguard/models/auth_model.dart';
import 'package:xguard/pager.dart';
import 'package:xguard/utils/customOverlay.dart';

class LoginController extends GetxController {
  PageController pageController = PageController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController names = TextEditingController();
  TextEditingController studentNumber = TextEditingController();

  var isFirstPage = true.obs;

  flushController() {
    email.clear();
    password.clear();
    names.clear();
    studentNumber.clear();
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  signIn(BuildContext context) async {
    names.clear();
    studentNumber.clear();
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        CustomOverlay.showLoaderOverlay(duration: 5);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);

        CustomOverlay.showToast(
            'Welcome back!, logging in', Colors.green, Colors.white);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Pager()));
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          CustomOverlay.showToast(
              'No account found, check your email and password',
              Colors.red,
              Colors.white);
        }

        print(e.code);
        if (e.code == 'user-not-found') {
          var authData = AuthUserModel(
              emailAddress: email.text,
              password: password.text,
              studentNumber: studentNumber.text,
              fullNames: names.text);
          print('No user found for that email.');
          // _createAccount(authData, context);
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          CustomOverlay.showToast(
              'You entered a wrong email/password', Colors.red, Colors.white);
        }
      }
    } else {
      CustomOverlay.showToast(
          'Fill all fields', Colors.orange[400]!, Colors.white);
    }
  }

  register() async {
    if (isFirstPage.value) {
      email.clear();
      password.clear();
      if (names.text.isNotEmpty && studentNumber.text.isNotEmpty) {
        isFirstPage(false);
        pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut);
      }
    } else {
      if (email.text.isNotEmpty && password.text.isNotEmpty) {

        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          CustomOverlay.showToast(
              'Creating account and signing in', Colors.green, Colors.white);
          FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
            'name': names.text,
            'student_number': studentNumber.text,
            'email_address': email.text
          });

          if (credential.user != null) {}
          return credential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
            CustomOverlay.showToast('Weak password, set a strong password',
                Colors.red, Colors.white);
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
            CustomOverlay.showToast('The account already exists for that email',
                Colors.red, Colors.white);
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  void onInit() {
    pageController.addListener(() {
      if (pageController.page == 1) {
        isFirstPage(false);
      }
    });
    super.onInit();
  }
}
