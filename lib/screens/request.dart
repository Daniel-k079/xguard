import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xguard/constants/strings.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/pages/sign-up.dart';
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
  final requestFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool unCategorizedVisitor = FirebaseAuth.instance.currentUser!.isAnonymous;
    return Stack(
      children: [
        TopHeader(
          title: unCategorizedVisitor
              ? 'unCategorizedVisitorGatePass'
              : createGatePass,
          subHeading: unCategorizedVisitor
              ? 'unCategorizedVisitorGatePassDescription'
              : createGatePassDescription,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Form(
            key: requestFormKey,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 200),
              shrinkWrap: true,
              children: <Widget>[
                unCategorizedVisitor
                    ? TextFieldBox(
                        title: 'Name of visitor',
                        hint: 'Write full name here',
                        textEditingController:
                            requestController.unCategorizedVisitor)
                    : const SizedBox.shrink(),
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
                    optionList: lecturers.sublist(2,7)
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
                  height: 140,
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
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100, right: 20.0, left: 20.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BouncingWidget(
              onPressed: () {
                if (validateAndSave(requestFormKey)) {
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
                    CustomOverlay.showToast(
                        'Fill all fields, to continue saving',
                        Colors.red,
                        Colors.white);
                  }
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

  bool validateAndSave(varFormKey) {
    final FormState? form = varFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

class TopHeader extends StatelessWidget {
  const TopHeader({
    Key? key,
    required this.title,
    required this.subHeading,
    this.showFace = false,
    this.showSignOutButton = false
  }) : super(key: key);

  final String title;
  final String subHeading;
  final bool showFace;
  final bool showSignOutButton;

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    return Container(
      width: double.infinity,
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
        padding: const EdgeInsets.only(
            top: 50, left: 20.0, right: 10.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                showFace
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text(
                                          'Opt in Face Scanning',
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins'),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        const Text(
                                          'How this works.\nYour face is scanned using your device camera and image is processed using Tensorflow and Google ML kit. Next time you need to access COCIS premises, simply scan your face to be granted.\n\nAre you sure you want to opt in for face scanning to gain access to the school premises? terminate this session',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins'),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const SignUp(),
                                                    ),
                                                  );
                                                },
                                                child: Text('Yes')),
                                            const SizedBox(width: 10.0),
                                            SizedBox(
                                              width: 100,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red),
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
                        },
                        icon: const Icon(Icons.face,
                            color: Colors.white, size: 30.0))
                    : const SizedBox.shrink(),
                showSignOutButton
                    ? IconButton(
                        onPressed: () {
                          loginController.logout(context);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ))
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              subHeading,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
