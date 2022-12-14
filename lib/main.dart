import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xguard/pager.dart';
import 'package:xguard/screens/homepage.dart';
import 'package:xguard/screens/login.dart';
import 'package:xguard/screens/phone_screen.dart';
import 'package:xguard/screens/reports.dart';
import 'firebase_options.dart';
import 'locator.dart';

Future<void> main() async {
  setupServices();
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  //setting portrait mode only to disable auto rotation on the app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Phoenix(child: const OKToast(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application. You might like to think of it as the wall of our
  // house on which we pin and hang our Pager which is our canvas
  @override
  Widget build(BuildContext context) {
    //This to dismiss the keyboard when there is a focused textfield
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      //setting screen ratio so it does not change with device DPI
      child: ScreenUtilInit(
          designSize: const Size(520, 890),
          builder: (context, w) => GetMaterialApp(
                title: 'XGuard',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                //Stream to listen for auth state changes
                home: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      //if user is anonymous then it is a lecturer and otherwise a student and when a user is empty then we route to the Login page
                      if (snapshot.data != null) {
                        if (FirebaseAuth.instance.currentUser!.isAnonymous) {
                          if (GetStorage().read('lecturer_name') ==
                              'UnCategorized Visitor') {
                            return const UnCategorizedVisitor();
                          } else if (GetStorage().read('lecturer_name') ==
                              'Super Admin') {
                            return const Reports();
                          } else {
                            return const LecturerViewPage();
                          }
                        } else {
                          return const Pager();
                        }
                      } else {
                        return const LoginPage();
                      }
                    }),
              )),
    );
  }
}

class UnCategorizedVisitor extends StatelessWidget {
  const UnCategorizedVisitor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PhoneScreen(),
    );
  }
}
