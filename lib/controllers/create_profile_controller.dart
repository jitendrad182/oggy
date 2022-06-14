import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oggy/const/image_const.dart';
import 'package:oggy/models/create_profile_model.dart';
import 'package:oggy/services/auth/auth.dart';
import 'package:oggy/views/dialogs/dialogs.dart';
import 'package:oggy/views/pages/onboarding/sign_up_page.dart';

class CreateProfileController extends GetxController {
  final Rx<CreateProfileModel> _createProfile = CreateProfileModel(
    avatar: 1,
    userName: 'UserName',
    userMobileNumber: 'userMobileNumber',
  ).obs;

  final AuthController _authController = Get.find();

  final key = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  int avatar() {
    return _createProfile.value.avatar;
  }

  String avatarImageConst() {
    return ImageConst.avatarImageConst(_createProfile.value.avatar);
  }

  String userName() {
    return _createProfile.value.userName;
  }

  String userMobileNumber() {
    return _createProfile.value.userMobileNumber;
  }

  void updateAvatar(int avatar) {
    _createProfile.update((val) {
      val!.avatar = avatar;
    });
  }

  void updateUserName(String userName) {
    _createProfile.update((val) {
      val!.userName = userName;
    });
  }

  void updateUserMobileNumber(String userMobileNumber) {
    _createProfile.update((val) {
      val!.userMobileNumber = userMobileNumber;
    });
  }

  void onTap(BuildContext context) async {
    if (key.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      updateUserName(nameController.text.trim());
      updateUserMobileNumber(numberController.text.trim());
      if (_authController.userId == 'userId') {
        Get.to(() => SignUpPage());
      } else {
        Dialogs.circularProgressIndicatorDialog(context);
        await _authController.helperFunction1();
      }
    }
  }
}
