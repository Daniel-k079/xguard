import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xguard/constants/strings.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/shared/shared.dart';
import 'package:xguard/utils/customOverlay.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final requestController = Get.put(RequestController());
  final NavigationController navController = Get.find();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Row(children: const [
                  Text(
                    createGatePass,
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
                  createGatePassDescription,
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
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              ChoicePicker(
                  optionList: visitReasons
                      .map((element) => DropdownMenuItem<String>(
                            value: element,
                            child: Text(
                              element,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ))
                      .toList(),
                  title: visitReasonTitle,
                  hint: visitReasonDescription,
                  selectedOption: requestController.visitReason,
                  onChanged: (value) {
                    setState(() {
                      requestController.visitReason = value!;
                    });
                  }),
              ChoicePicker(
                  optionList: lecturers
                      .map((element) => DropdownMenuItem<String>(
                            value: element['name'],
                            child: Text(
                              element['name'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ))
                      .toList(),
                  title: personToMeetTitle,
                  hint: personToMeetDescription,
                  selectedOption: requestController.personToMeet,
                  onChanged: (value) {
                    setState(() {
                      requestController.personToMeet = value!;
                    });
                  }),
              SizedBox(
                height: 240,
                child: CupertinoDatePicker(
                    minimumDate: DateTime.now(),
                    maximumDate: DateTime.now().add(const Duration(days: 7)),
                    use24hFormat: true,
                    onDateTimeChanged: (value) {
                      setState(() {
                        requestController.visitDate = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 100.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 140, right: 20.0, left: 20.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BouncingWidget(
              onPressed: () {
                if (requestController.visitReason.isNotEmpty &&
                    requestController.personToMeet.isNotEmpty &&
                    requestController.visitDate.isNotEmpty) {
                  requestController.makeRequest().then((value) {
                    CustomOverlay.showToast(
                        'Request added successfully, check your main page',
                        Colors.green,
                        Colors.white);
                    requestController.visitReason = '';
                    requestController.personToMeet = '';
                    requestController.visitDate = '';
                    navController.pageSwitcher(0);
                  });
                } else {
                  CustomOverlay.showToast('Fill all fields, to continue saving',
                      Colors.red, Colors.white);
                }
              },
              child: Container(
                height: 70.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(255, 72, 95, 121)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Make Request',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
