import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xguard/shared/text_box.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Stream<DocumentSnapshot>? userStream;
  var userUid = FirebaseAuth.instance.currentUser!.uid;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    userStream =
        FirebaseFirestore.instance.collection('users').doc(userUid).snapshots();
    super.initState();
  }

  List images = [null, null, null, null];
  bool imagesAdded = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool isPicAdded = GetStorage().read('imagesAdded') ?? false;
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
              if (snapshot.data != null) {
                data = snapshot.data?.data();
              }
              return !snapshot.data!.exists
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 220.0),
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
                          const SizedBox(
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
                              value: data['email_address']),
                          const SizedBox(height: 10),
                          !isPicAdded
                              ? CupertinoButton(
                                  child:
                                      const Text('Upload Photos to Complete '),
                                  onPressed: () async {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.purple[100],
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(12.0))),
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: ((context, setState) {
                                            return imagesAdded
                                                ? Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      Text(
                                                          'Thank you for taking all pictures',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 23.0,
                                                          )),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Text(
                                                          'They are being synced with the server',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 13.0,
                                                          )),
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      LinearProgressIndicator()
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 210,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          const Text(
                                                              'Take Pictures',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 23.0,
                                                              )),
                                                          const SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          const Text(
                                                              'These picture posses are used to doe the AI model',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 13.0,
                                                              )),
                                                          const SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          SizedBox(
                                                            height: 100,
                                                            child: ListView
                                                                .builder(
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount:
                                                                        4,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            final XFile?
                                                                                photo =
                                                                                await _picker.pickImage(source: ImageSource.camera);

                                                                            setState(() {
                                                                              images[index] = photo!.path;
                                                                            });
                                                                            if (images.every((element) =>
                                                                                element !=
                                                                                null)) {
                                                                              List imageURLS = [];
                                                                              imagesAdded = true;
                                                                              int counter = 0;

                                                                              while (counter < 4) {
                                                                                firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref().child('${data['name']}/${data['name']}-${images.indexOf(images[counter])}');

                                                                                storageReference.putFile(File(images[counter]));

                                                                                storageReference.getDownloadURL();
                                                                                imageURLS.add(storageReference.getDownloadURL());

                                                                                if (counter == 3) {
                                                                                  FirebaseFirestore.instance.collection('users').doc(userUid).update({
                                                                                    'image_urls': imageURLS
                                                                                  });
                                                                                  GetStorage().write('imagesAdded', true);

                                                                                  Navigator.pop(context);
                                                                                }
                                                                                counter++;
                                                                              }
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                90.0,
                                                                            decoration: BoxDecoration(
                                                                                image: images[index] != null ? DecorationImage(fit: BoxFit.cover, image: FileImage(File(images[index]))) : null,
                                                                                border: Border.all(),
                                                                                shape: BoxShape.circle),
                                                                            child: images[index] == null
                                                                                ? Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: const <Widget>[
                                                                                      Text('Take\nSelfie',
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'Poppins',
                                                                                            fontSize: 13.0,
                                                                                          )),
                                                                                    ],
                                                                                  )
                                                                                : null,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                          }));
                                        });
                                  })
                              : const SizedBox.shrink()
                        ],
                      ),
                    );
            })
      ],
    );
  }
}
