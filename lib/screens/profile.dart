import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xguard/shared/shared.dart';
import 'package:xguard/shared/text_box.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Stream<DocumentSnapshot>? userStream;
  var userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    userStream =
        FirebaseFirestore.instance.collection('users').doc(userUid).snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: size.height * 0.23,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 33, 163, 243),
                Color.fromARGB(255, 23, 148, 165),
                Color.fromARGB(255, 134, 91, 227)
              ],
              begin: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Row(children: const [
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ]),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'This is your personal info and is not shared with anyone',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
        StreamBuilder<DocumentSnapshot>(
            stream: userStream,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              var data;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LinearProgressIndicator(),
                );
              }
              if (snapshot.data!.exists) {
                data = snapshot.data?.data();
              }
              return !snapshot.data!.exists
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 200.0),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        children: <Widget>[
                          Row(
                            children: <Widget>[
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
                                              color: Color.fromARGB(
                                                  255, 121, 121, 121)),
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
                                              color: Color.fromARGB(
                                                  255, 121, 121, 121)),
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
                                              color: Color.fromARGB(
                                                  255, 121, 121, 121)),
                                        ),
                                      ]))
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextBox(
                            title: 'Student Name',
                            value: data['name'],
                          ),
                          TextBox(
                              title: 'Student Registration Number',
                              value: data['student_number']),
                          TextBox(
                              title: 'Email Address',
                              value: data['email_address'])
                        ],
                      ),
                    );
            })
      ],
    );
  }
}
