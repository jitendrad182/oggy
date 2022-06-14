import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oggy/const/string_const.dart';
import 'package:oggy/main.dart';
import 'package:oggy/services/data/api.dart';
import 'package:oggy/services/db/db_1.dart';
import 'package:oggy/services/db/db_2.dart';
import 'package:oggy/views/dialogs/dialogs.dart';
import 'package:oggy/views/pages/home/home.dart';
import 'package:oggy/views/pages/onboarding/onboarding_page_1.dart';
import 'package:oggy/views/pages/onboarding/onboarding_page_2.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  final Api _api = Get.put(Api(), permanent: true);

  bool isSignedIn = false;
  String userId = 'userId';
  int userInfo = 0;

  api() async {
    await _api.getCities();
  }

  doThis() async {
    isSignedIn = true;
    userId = _auth.currentUser!.uid;
  }

  currentUser() async {
    return _asyncMemoizer.runOnce(
      () async {
        if (_auth.currentUser?.uid != null) {
          doThis();
          await getUserInfo();
        }
        await api();
        return _auth.currentUser;
      },
    );
  }

  getUserInfo() async {
    final dbController2 = Get.put(DbController2(), permanent: true);
    await dbController2.getMyInfo();
    userInfo = dbController2.length();
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
    isSignedIn = false;
    userId = 'userId';
    userInfo = 0;
    Get.offAll(() => const OnboardingPage1());
  }

  forgotPassword(String email, BuildContext context) async {
    Dialogs.circularProgressIndicatorDialog(context);
    try {
      await _auth.sendPasswordResetEmail(email: email).then(
        (value) {
          navigatorKey.currentState!.pop();
          Dialogs.defaultDialog1(
              StringConst.resetPassword, StringConst.passwordResetEmail);
        },
      ).catchError(
        (e) {
          navigatorKey.currentState!.pop();
          Dialogs.defaultErrorDialog1(StringConst.error, e.message.toString());
        },
      );
    } catch (e) {
      navigatorKey.currentState!.pop();
      Dialogs.defaultErrorDialog1(
          StringConst.error, StringConst.anUnexpectedError);
    }
  }

  createUser(
      {String? email, String? password, required BuildContext context}) async {
    Dialogs.circularProgressIndicatorDialog(context);
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
      User? user = userCredential.user;
      if (user != null) {
        doThis();
        await helperFunction1();
      }
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Dialogs.defaultErrorDialog1(StringConst.error, e.message.toString());
    } catch (e) {
      navigatorKey.currentState!.pop();
      Dialogs.defaultErrorDialog1(
          StringConst.error, StringConst.anUnexpectedError);
    }
  }

  signInWithEmail(
      {String? email, String? password, required BuildContext context}) async {
    Dialogs.circularProgressIndicatorDialog(context);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      User? user = userCredential.user;
      if (user != null) {
        doThis();
        await getUserInfo();
        await helperFunction2();
      }
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Dialogs.defaultErrorDialog1(StringConst.error, e.message.toString());
    } catch (e) {
      navigatorKey.currentState!.pop();
      Dialogs.defaultErrorDialog1(
          StringConst.error, StringConst.anUnexpectedError);
    }
  }

  signInWithGoogle(bool isSignInPage, BuildContext context) async {
    Dialogs.circularProgressIndicatorDialog(context);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        return await helperFunction3(isSignInPage);
      }
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Dialogs.defaultErrorDialog1(StringConst.error, e.message.toString());
    }
  }

  signInWithFacebook(bool isSignInPage, BuildContext context) async {
    Dialogs.circularProgressIndicatorDialog(context);
    try {
      final LoginResult loginResult = await _facebookAuth.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      User? user = userCredential.user;
      if (user != null) {
        return await helperFunction3(isSignInPage);
      }
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Dialogs.defaultErrorDialog1(StringConst.error, e.message.toString());
    }
  }

  helperFunction1() async {
    await DbController1().saveUserInfo().then((value) async {
      final DbController2 dbController2 =
          Get.put(DbController2(), permanent: true);
      await dbController2.getMyInfo();
      userInfo = dbController2.length();
      Get.offAll(() => const HomePage());
    });
  }

  helperFunction2() {
    if (userInfo < 1) {
      Get.to(() => OnboardingPage2());
    } else {
      Get.offAll(() => const HomePage());
    }
  }

  helperFunction3(bool isSignInPage) async {
    await doThis();
    if (isSignInPage) {
      await getUserInfo();
      return helperFunction2();
    } else {
      return await helperFunction1();
    }
  }
}
