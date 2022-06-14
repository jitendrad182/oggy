import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oggy/const/color_const.dart';
import 'package:oggy/const/string_const.dart';
import 'package:oggy/services/auth/auth.dart';
import 'package:oggy/views/pages/error_page.dart';
import 'package:oggy/views/pages/home/home.dart';
import 'package:oggy/views/pages/onboarding/onboarding_page_1.dart';
import 'package:oggy/views/pages/onboarding/onboarding_page_2.dart';
import 'package:oggy/views/pages/waiting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle().copyWith(
    statusBarColor: ColorConst.whiteColor,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _auth = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConst.appTitle,
      navigatorKey: navigatorKey,
      theme: ThemeData.light(),
      home: FutureBuilder(
        future: _auth.currentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingPage();
          } else if (snapshot.hasError) {
            return const ErrorPage();
          } else if (snapshot.hasData) {
            if (_auth.userInfo >= 1) {
              return const HomePage();
            } else {
              return OnboardingPage2();
            }
          } else {
            return const OnboardingPage1();
          }
        },
      ),
    );
  }
}
