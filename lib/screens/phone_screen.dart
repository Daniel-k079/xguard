import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:xguard/controllers/login_controller.dart';
import 'package:xguard/controllers/phone_controller.dart';
import 'package:xguard/shared/key_pad.dart';
import 'package:xguard/shared/text_field_box.dart';
import 'package:xguard/utils/customOverlay.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  var phoneScreenController = Get.put(KeyPadController());
  var lock = GetStorage().read('key_lock') ?? '';
  User user = FirebaseAuth.instance.currentUser!;
  PageController ussdPageController = PageController();

  List timeSlots = ['9:00am', '10:00am', '1:00pm', '3:00pm'];
  List lecturerSlots = [
    'Swaib Dragule',
    'Rose Nakibuule',
    'Micheal Kizito',
    'Engineer Baino',
    'Joyce Nabende'
  ];

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    return Column(children: <Widget>[
      const Spacer(),

      GestureDetector(
        onTap: () {
          loginController.logout(context);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Phone Dialer',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  CupertinoIcons.phone_solid,
                  color: Colors.green,
                  size: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),

      const Spacer(),
      Obx(() {
        return Stack(
          children: [
            TextFormField(
              readOnly: true,
              textAlign: TextAlign.center,
              controller: phoneScreenController.amountController.value,
              decoration: const InputDecoration(border: InputBorder.none),
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 54.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            Positioned(
                right: 60.0,
                top: 25.0,
                child: IconButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      if (phoneScreenController
                          .amountController.value.text.isNotEmpty) {
                        phoneScreenController.amountController.value.text =
                            phoneScreenController
                                .amountController.value.value.text
                                .substring(
                                    0,
                                    phoneScreenController.amountController.value
                                            .value.text.length -
                                        1);
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.backspace,
                      size: 30,
                      color: Colors.red,
                    )))
          ],
        );
      }),
      Divider(
        color: Colors.grey[400]!,
      ),

      ///here we make a grid of 9 blocks and inflate it with the KeyPad buttons, and
      ///pass the index value plus 1

      GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 25.0),
          itemCount: 9,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 65.0,
              mainAxisSpacing: 30,
              crossAxisSpacing: 10,
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return KeyPadButton(
                index: index,
                numberStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins'),
                letterStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins'),
                tapAction: () {
                  HapticFeedback.lightImpact();
                  phoneScreenController.insertText(
                      '${index + 1}', phoneScreenController.amountController);
                  setState(() {});
                });
          }),

      Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 50.0,
          right: 50.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            KeyPadButton(
              numberStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
              letterStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
              index: 9,
              tapAction: () {
                phoneScreenController.insertText(
                    '*', phoneScreenController.amountController);
              },
            ),
            KeyPadButton(
              numberStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
              letterStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
              index: 10,
              tapAction: () {
                phoneScreenController.insertText(
                    '0', phoneScreenController.amountController);
                setState(() {});
              },
            ),
            KeyPadButton(
              numberStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
              letterStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
              index: 11,
              tapAction: () {
                phoneScreenController.insertText(
                    '#', phoneScreenController.amountController);
              },
            ),
          ],
        ),
      ),
      const Spacer(),
      Container(
          height: 60.0,
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: BouncingWidget(
              child: Container(
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.blue, shape: BoxShape.circle),
                child: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (phoneScreenController.amountController.value.text ==
                    "*280#") {
                  CustomOverlay.showLoaderOverlay(duration: 1);
                  await Future.delayed(const Duration(seconds: 1));

                  // ignore: use_build_context_synchronously
                  showUssdDialog(context);
                } else {
                  CustomOverlay.showToast(
                      'Unknown Service Code', Colors.red, Colors.white);
                }
              })),

      const Spacer(),
    ]);
  }

  Future<dynamic> showUssdDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Hello, welcome to GuardX\nYou can make your appointment with a lecturer',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 200.0,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: ussdPageController,
                    children: [
                      const Text(
                        'Enter 1, to continue',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'What lecturer would you like to meet?',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ListView.builder(
                            itemCount: lecturerSlots.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  'Enter $index for ${lecturerSlots[index]}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Please choose time for your meeting',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),
                          ListView.builder(
                            itemCount: timeSlots.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  'Enter $index for ${timeSlots[index]}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              'Confirm your appointment with ${phoneScreenController.selectedLecturer} at ${phoneScreenController.selectedTime} by inputting your student number',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins'),
                            );
                          }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Enter student number',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                TextFieldBox(
                    title: '',
                    hint: 'enter here',
                    textEditingController: phoneScreenController.ussdOption),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    TextButton(
                      child: const Text(
                        'Send',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'),
                      ),
                      onPressed: () {
                        switch (ussdPageController.page!.round()) {
                          case 0:
                            if (phoneScreenController.ussdOption.text == '1') {
                              ussdPageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear);
                            } else {
                              CustomOverlay.showToast(
                                  'You entered a wrong input',
                                  Colors.red,
                                  Colors.white);
                            }
                            break;

                          case 1:
                            setState(() {
                              phoneScreenController.selectedLecturer.value =
                                  lecturerSlots[int.parse(phoneScreenController
                                      .ussdOption.value.text)];
                            });

                            ussdPageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);

                            break;

                          case 2:
                            setState(() {
                              phoneScreenController.selectedTime.value =
                                  timeSlots[int.parse(phoneScreenController
                                      .ussdOption.value.text)];
                            });
                            ussdPageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);

                            break;

                          case 3:
                            FirebaseFirestore.instance
                                .collection('requests')
                                .doc(user.uid)
                                .collection('my_passes')
                                .add({
                              'visit_date':
                                  phoneScreenController.selectedTime.value,
                              "selected_time":
                                  phoneScreenController.selectedTime.value,
                              "person_to_meet":
                                  phoneScreenController.selectedLecturer.value,
                              "student_name":
                                  phoneScreenController.ussdOption.value.text,
                              "permitted": 0,
                              "visit_reason": "Appointment Request"
                            });
                            CustomOverlay.showToast(
                                'Request Sent', Colors.green, Colors.white);
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'QR Code',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 20.0),
                                          const Text(
                                            'Take a screenshot of this QR Code and you will present it when asked upon',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(height: 10.0),
                                          SizedBox(
                                              height: 140.0,
                                              width: 140.0,
                                              child: QrImage(
                                                  data:
                                                      'ACCEPTED,\n your appointment request was sent to ${phoneScreenController.selectedLecturer.value},\nTime slot ${phoneScreenController.selectedTime.value} '))
                                        ],
                                      ),
                                    ),
                                  );
                                });

                            break;

                          default:
                            CustomOverlay.showToast('You entered a wrong input',
                                Colors.red, Colors.white);
                        }
                        phoneScreenController.ussdOption.clear();
                        setState(() {});
                      },
                    )
                  ],
                )
              ],
            ),
          ));
        });
  }
}
