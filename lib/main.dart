import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xguard/pager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'XGuard',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Pager(),
      ),
    );
  }
}
