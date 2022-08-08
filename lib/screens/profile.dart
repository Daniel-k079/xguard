import 'package:flutter/material.dart';
import 'package:xguard/shared/shared.dart';
import 'package:xguard/shared/text_box.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: size.height * 0.19,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(122, 163, 187, 1),
              Color.fromARGB(255, 26, 85, 136)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                Row(children: const [
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  )
                ]),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'This is your personal info and is not shared with anyone',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage('assets/images/vivian.png'),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: const TextSpan(
                              text: 'Account Status:',
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                              text: 'Verified',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 121, 121, 121)),
                            ),
                          ])),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                          text: const TextSpan(
                              text: 'COCIS Resident:',
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                              text: 'Yes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 121, 121, 121)),
                            ),
                          ])),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                          text: const TextSpan(
                              text: 'Restrictions: ',
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                              text: 'None',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 121, 121, 121)),
                            ),
                          ]))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextBox(title: 'Student Name', value: 'Naulumu Vivian'),
              TextBox(
                  title: 'Student Registration Number',
                  value: '19/U/17293/EVE'),
              TextBox(title: 'Email Address', value: 'nalumuvivian@gmail.com')
            ],
          ),
        )
      ],
    );
  }
}
