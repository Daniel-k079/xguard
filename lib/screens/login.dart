import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xguard/controllers/login_controller.dart';
import 'package:xguard/models/auth_model.dart';

enum LoginStates { blank, register, login }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Get.put(LoginController());

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
                  Spacer(),
                  Text(
                    'GuardX',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 48.0,
                        color: Colors.white,
                        fontFamily: 'Comfortaa'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Come on board.',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
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
                  Spacer(),
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
                    height: 60.0,
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
                              icon: Icon(CupertinoIcons.arrow_turn_up_left,
                                  color: Colors.white),
                            )),
                        SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Let\'s get you started',
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
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
                        Spacer(),
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
                                  SizedBox(
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
                                        decoration: InputDecoration(
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
                                        decoration: InputDecoration(
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
                                  SizedBox(
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
                                        decoration: InputDecoration(
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
                        Spacer(),
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
                                    style: TextStyle(
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
                        Spacer(),
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
                              icon: Icon(CupertinoIcons.arrow_turn_up_left,
                                  color: Colors.white),
                            )),
                        SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Let\'s sign you in',
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Text(
                            'Welcome back,\nyou have been missed.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.white),
                          ),
                        ),
                        Spacer(),
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
                              decoration: InputDecoration(
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
                        SizedBox(
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
                              decoration: InputDecoration(
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
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: BouncingWidget(
                            onPressed: () {

                              loginController.signIn( context);
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
                        Spacer(),
                      ]),
      ),
    );
  }
}
