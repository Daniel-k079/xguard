import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xguard/constants/strings.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/models/auth_model.dart';
import 'package:xguard/pager.dart';
import 'package:xguard/shared/shared.dart';
import 'package:xguard/utils/customOverlay.dart';

class LoginController extends GetxController {
  PageController pageController = PageController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController names = TextEditingController();
  TextEditingController studentNumber = TextEditingController();
  final passWordController = TextEditingController();

  var isFirstPage = true.obs;

  ///dispose the text editing controller values
  flushController() {
    email.clear();
    password.clear();
    names.clear();
    studentNumber.clear();
  }

  ///sign out method
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  ///log in method
  Future signIn(BuildContext context) async {
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
        // ignore: use_build_context_synchronously
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


        if (e.code == 'user-not-found') {


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
            duration: const Duration(milliseconds: 300),
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
          CustomOverlay.showLoaderOverlay(duration: 6);
          CustomOverlay.showToast(
              'Creating account and signing in', Colors.green, Colors.white);
          GetStorage()
              .write('student_name', '${names.text}, ${studentNumber.text}');
          print(GetStorage().read(
            'student_name',
          ));
          FirebaseFirestore.instance
              .collection('users')
              .doc(credential.user!.uid)
              .set({
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

  Future<void> showLecturerSheet(BuildContext context) {
    final requestController = Get.put(RequestController());
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 5.0, right: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Welcome,\nlet us recognize you',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ChoicePicker(
                    optionList: lecturers
                        .sublist(0, 5)
                        .map((element) => DropdownMenuItem<String>(
                              value: element['password'],
                              child: Text(
                                element['name'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ))
                        .toList(),
                    title: 'Choose name below ',
                    hint: personToMeetDescription,
                    selectedOption: requestController.personToMeet,
                    onChanged: (value) {
                      Map<String, dynamic> data = lecturers.firstWhere(
                          (element) => element.containsValue(value));
                      GetStorage().write('lecturer_name', data['name']);

                      requestController.tempPassword.value = value!;

                      
                      requestController.personToMeet = value;
                      requestController.tempLecturer.value = data['name'];
                    }),
                const SizedBox(
                  height: 10.0,
                ),
                TextFieldBox(
                    title: 'Input admin password',
                    hint: 'Write here',
                    textEditingController: passWordController),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                            color: Colors.blue,
                            child: const Text('login In'),
                            onPressed: () async {
                              if (passWordController.text ==
                                  requestController.tempPassword.value) {
                                Navigator.pop(context);
                                CustomOverlay.showLoaderOverlay(duration: 6);
                                await FirebaseAuth.instance.signInAnonymously();
                              } else {
                                CustomOverlay.showToast(
                                    'You entered a wrong password',
                                    Colors.red,
                                    Colors.white);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
