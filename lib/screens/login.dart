import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xguard/controllers/login_controller.dart';
import 'package:xguard/pager.dart';
import 'package:xguard/shared/text_field_box.dart';
import 'package:xguard/constants/strings.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/shared/shared.dart';
import 'package:xguard/utils/customOverlay.dart';

enum LoginStates { blank, register, login }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Get.put(LoginController());
  final requestController = Get.put(RequestController());
  final passWordController = TextEditingController();
  int currentState = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Color.fromARGB(255, 33, 163, 243),
          Color.fromARGB(255, 23, 148, 165),
          Color.fromARGB(255, 134, 91, 227)
        ])),
        child: currentState == LoginStates.blank.index
            ? Column(
                children: [
                  const Spacer(),
                  const Text(
                    'GuardX',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 48.0,
                        color: Colors.white,
                        fontFamily: 'Comfortaa'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Come on board.',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Create a free account and conveniently manage your gate pass access.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentState = LoginStates.login.index;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(18.0)),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 53.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentState = LoginStates.register.index;
                            });
                          },
                          child: Container(
                            height: 70.0,
                            width: size.width / 2.2,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 77, 60, 227),
                                borderRadius: BorderRadius.circular(18.0)),
                            child: const Center(
                                child: Text(
                              'Register',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 35.0, left: 5.0, right: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
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
                                            .map((element) =>
                                                DropdownMenuItem<String>(
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
                                        selectedOption:
                                            requestController.personToMeet,
                                        onChanged: (value) {
                                          Map<String, dynamic> data =
                                              lecturers.firstWhere((element) =>
                                                  element.containsValue(value));
                                          GetStorage().write(
                                              'lecturer_name', data['name']);
                                          setState(() {
                                            requestController
                                                .tempPassword.value = value!;

                                            print(data['name']);
                                            requestController.personToMeet =
                                                value;
                                            requestController.tempLecturer.value =
                                                data['name'];
                                          });
                                        }),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFieldBox(
                                        title: 'Input admin password',
                                        hint: 'Write here',
                                        textEditingController:
                                            passWordController),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CupertinoButton(
                                                color: Colors.blue,
                                                child: const Text('login In'),
                                                onPressed: () async {
                                                  if (passWordController.text ==
                                                      requestController
                                                          .tempPassword.value) {
                                                    Navigator.pop(context);
                                                    CustomOverlay
                                                        .showLoaderOverlay(
                                                            duration: 6);
                                                    await FirebaseAuth.instance
                                                        .signInAnonymously();
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
                      },
                      child: const Text(
                        'Log in as a lecturer',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      )),
                  const SizedBox(
                    height: 40.0,
                  )
                ],
              )
            : currentState == LoginStates.register.index
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const Spacer(),
                        Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  currentState = LoginStates.blank.index;
                                });
                              },
                              icon: const Icon(
                                  CupertinoIcons.arrow_turn_up_left,
                                  color: Colors.white),
                            )),
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Let\'s get you started',
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Happy to see you,\nyou will like it with us.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.white),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 180,
                          child: PageView(
                            controller: loginController.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.3, color: Colors.white),
                                          color: Colors.white12,
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      child: TextFormField(
                                        controller: loginController.names,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Full names',
                                          helperText: '',
                                          contentPadding: EdgeInsets.only(
                                              left: 25.0, top: 40),
                                          hintStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.3, color: Colors.white),
                                          color: Colors.white12,
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      child: TextFormField(
                                        controller:
                                            loginController.studentNumber,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Student number',
                                          helperText: '',
                                          contentPadding: EdgeInsets.only(
                                              left: 25.0, top: 40),
                                          hintStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.3, color: Colors.white),
                                          color: Colors.white12,
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      child: TextFormField(
                                        controller: loginController.email,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email address',
                                          helperText: '',
                                          contentPadding: EdgeInsets.only(
                                              left: 25.0, top: 40),
                                          hintStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.3, color: Colors.white),
                                          color: Colors.white12,
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      child: TextFormField(
                                        controller: loginController.password,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          helperText: '',
                                          contentPadding: EdgeInsets.only(
                                              left: 25.0, top: 40),
                                          hintStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: BouncingWidget(
                            onPressed: () {
                              loginController.register();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Obx(() {
                                  return Text(
                                    loginController.isFirstPage.value
                                        ? 'Continue'
                                        : 'Create Account',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const Spacer(),
                        Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  currentState = LoginStates.blank.index;
                                });
                              },
                              icon: const Icon(
                                  CupertinoIcons.arrow_turn_up_left,
                                  color: Colors.white),
                            )),
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Let\'s sign you in',
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Welcome back,\nyou have been missed.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.white),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.3, color: Colors.white),
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(18.0)),
                            child: TextFormField(
                              controller: loginController.email,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email address',
                                helperText: '',
                                contentPadding:
                                    EdgeInsets.only(left: 25.0, top: 40),
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.3, color: Colors.white),
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(18.0)),
                            child: TextFormField(
                              controller: loginController.password,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                helperText: '',
                                contentPadding:
                                    EdgeInsets.only(left: 25.0, top: 40),
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: BouncingWidget(
                            onPressed: () {
                              loginController.signIn(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ]),
      ),
    );
  }
}
