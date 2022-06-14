import 'package:flutter/material.dart';
import 'package:oggy/const/color_const.dart';
import 'package:oggy/const/image_const.dart';
import 'package:oggy/utils/app_sizes.dart';
import 'package:oggy/views/widgets/custom_app_bars/custom_app_bar_1.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSizes.mediaQueryHeightWidth();
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      appBar: appBar1,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              ImageConst.oggy,
              height: AppSizes.height10 * 13,
            ),
            const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
