import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:oggy/const/firebase_const.dart';
import 'package:oggy/const/image_const.dart';
import 'package:oggy/models/create_profile_model.dart';

class DbController2 extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _docId;

  final RxList<CreateProfileModel> _userProfileModel =
      <CreateProfileModel>[].obs;

  Future<void> getMyInfo() async {
    _userProfileModel.removeRange(0, _userProfileModel.length);
    try {
      await _firestore
          .collection(FirebaseConst.users)
          .doc(_auth.currentUser?.uid)
          .get()
          .then((querySnapshot) async {
        _userProfileModel.add(CreateProfileModel(
          avatar: querySnapshot.data()![FirebaseConst.avatar],
          userName: querySnapshot.data()![FirebaseConst.userName],
          userMobileNumber:
              querySnapshot.data()![FirebaseConst.userMobileNumber],
        ));
        _docId = querySnapshot.data()![FirebaseConst.userId];
      });
    } catch (e) {
      if (kDebugMode) {
        print('DbController2 getMyInfo Error = $e');
      }
    }
  }

  int length() {
    return _userProfileModel.length;
  }

  String userId() {
    return _docId;
  }

  int avatar() {
    return _userProfileModel[0].avatar;
  }

  String avatarImageConst() {
    return ImageConst.avatarImageConst(_userProfileModel[0].avatar);
  }

  String userName() {
    return _userProfileModel[0].userName;
  }

  String userMobileNumber() {
    return _userProfileModel[0].userMobileNumber;
  }
}
