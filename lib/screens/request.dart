import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xguard/controllers/controller.dart';
import 'package:xguard/shared/shared.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final requestController = Get.put(RequestController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
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
                    'Create Gate Pass Access',
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
                  'Here you can create your gate access to help you save time on the next time you are accessing the premises',
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
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              TextFieldBox(
                title: 'Reason of visit',
                hint: 'Specify reason for visiting here',
                textEditingController: requestController.visitReason,
              ),
                     TextFieldBox(
                title: 'Date of visit',
                hint: 'Why would you like to visit ?',
                textEditingController: requestController.visitDate,
              ),
              const SizedBox(height: 100.0,),

            ],
          ),
        ),
            Padding(
                padding: const EdgeInsets.only(bottom: 140,  right: 20.0, left: 20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(height: 70.0,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Color.fromARGB(255, 72, 95, 121)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('Make Request', style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  ),
                ),
              )
      ],
    );
  }
}
