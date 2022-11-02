import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xguard/constants/strings.dart';
import 'package:xguard/controllers/controller.dart';
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

  ///log in method
  Future signIn(BuildContext context) async {
    names.clear();
    studentNumber.clear();
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      CustomOverlay.showToast('Trying to log in', Colors.orange, Colors.white);
      await Future.delayed(const Duration(milliseconds: 500));
      CustomOverlay.showLoaderOverlay(duration: 2);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);
        if (credential.user != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(credential.user!.uid)
              .get()
              .then((value) {
            GetStorage().write(
                'student_names', value['name'] + '-' + value['student_number']);
          });
        }

        CustomOverlay.showToast(
            'Welcome back!, logging in', Colors.green, Colors.white);

        return credential;
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'invalid-email') {
          CustomOverlay.showToast(
              'No account found, check your email and password',
              Colors.red,
              Colors.white);
        }

        if (e.code == 'user-not-found') {
          CustomOverlay.showToast('User not found, sign up for an account',
              Colors.red, Colors.white);
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
          CustomOverlay.showToast(
              'Trying to log in', Colors.orange, Colors.white);
          await Future.delayed(const Duration(milliseconds: 500));
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          CustomOverlay.showLoaderOverlay(duration: 6);
          CustomOverlay.showToast(
              'Creating account and signing in', Colors.green, Colors.white);
          GetStorage()
              .write('student_names', '${names.text}, ${studentNumber.text}');

          FirebaseFirestore.instance
              .collection('users')
              .doc(credential.user!.uid)
              .set({
            'name': names.text,
            'student_number': studentNumber.text,
            'email_address': email.text
          });
          CustomOverlay.showToast(
              'Account has been created', Colors.green, Colors.white);
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

  Future logout(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Do you want to log out?',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Are you sure you want to terminate this session',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            FirebaseAuth.instance.signOut();
                            await Get.deleteAll(force: true);
                            Phoenix.rebirth(context);
                            Get.reset();
                          },
                          child: Text('Yes')),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No')),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
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
        backgroundColor: Colors.purple[100],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              top: 45.0,
              left: 5.0,
              right: 5.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Welcome,\nlet us recognize you',
                      style: TextStyle(fontSize: 28.0, fontFamily: 'Poppins'),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ChoicePicker(
                      optionList: lecturers
                          .sublist(0, lecturers.length - 1)
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
                    height: 8.0,
                  ),
                  TextFieldBox(
                      isPassword: true,
                      title: 'Input password',
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
                          child: SizedBox(
                            height: 60.0,
                            child: CupertinoButton(
                                color: Colors.purple[800],
                                child: const Text(
                                  'Login In',
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                                onPressed: () async {
                                  CustomOverlay.showToast('Trying to log in',
                                      Colors.orange, Colors.white);
                                  await Future.delayed(
                                      const Duration(milliseconds: 500));
                                  if (requestController
                                      .tempPassword.value.isEmpty) {
                                    CustomOverlay.showToast(
                                        'Pick a user (lecturer)',
                                        Colors.red,
                                        Colors.white);
                                  } else if (passWordController.text.isEmpty) {
                                    CustomOverlay.showToast(
                                        'Enter a password to continue',
                                        Colors.red,
                                        Colors.white);
                                  } else if (passWordController.text ==
                                      requestController.tempPassword.value) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    await FirebaseAuth.instance
                                        .signInAnonymously();
                                  } else {
                                    CustomOverlay.showToast(
                                        'You entered a wrong password ',
                                        Colors.red,
                                        Colors.white);
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
