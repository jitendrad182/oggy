import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oggy/const/color_const.dart';
import 'package:oggy/const/image_const.dart';
import 'package:oggy/const/string_const.dart';
import 'package:oggy/services/auth/auth.dart';
import 'package:oggy/services/db/db_2.dart';
import 'package:oggy/utils/app_sizes.dart';
import 'package:oggy/views/pages/home/home.dart';

class Drawer1 extends StatelessWidget {
  Drawer1({Key? key}) : super(key: key);

  final AuthController _authController = Get.find();
  final DbController2 _dbController2 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConst.whiteColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ImageConst.bg),
              ),
            ),
            accountName: Text(
              _dbController2.userName(),
              style: const TextStyle(
                color: ColorConst.whiteColor,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                  height: AppSizes.height10 * 10,
                  fit: BoxFit.cover,
                  image: AssetImage(
                    _dbController2.avatarImageConst(),
                  ),
                ),
              ),
            ),
            accountEmail: Text(
              _dbController2.userMobileNumber(),
              style: const TextStyle(
                color: ColorConst.whiteColor,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text(StringConst.home),
              onTap: () {
                if (Get.currentRoute != '/' &&
                    Get.currentRoute != '/HomePage') {
                  Get.offAll(() => const HomePage());
                }
              }),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(StringConst.logout),
            onTap: () async {
              await _authController.signOut();
            },
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
