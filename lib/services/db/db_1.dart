import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:oggy/const/firebase_const.dart';
import 'package:oggy/controllers/create_profile_controller.dart';

class DbController1 extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CreateProfileController _createProfileController = Get.find();

  Future<void> saveUserInfo() async {
    try {
      User? user = _auth.currentUser;
      return _firestore.collection(FirebaseConst.users).doc(user!.uid).set(
        {
          FirebaseConst.userId: user.uid,
          FirebaseConst.avatar: _createProfileController.avatar(),
          FirebaseConst.userName: _createProfileController.userName(),
          FirebaseConst.userMobileNumber:
              _createProfileController.userMobileNumber(),
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('DbController1 saveUserInfo Error = $e');
      }
    }
  }
}
