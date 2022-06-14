import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oggy/const/color_const.dart';
import 'package:oggy/const/image_const.dart';
import 'package:oggy/const/string_const.dart';
import 'package:oggy/utils/app_sizes.dart';
import 'package:oggy/views/pages/onboarding/onboarding_page_2.dart';
import 'package:oggy/views/pages/onboarding/sign_in_page.dart';
import 'package:oggy/views/widgets/custom_app_bars/custom_app_bar_1.dart';
import 'package:oggy/views/widgets/custom_buttons/custom_button_1.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSizes.mediaQueryHeightWidth();
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      appBar: appBar1,
      body: SafeArea(
        child: Padding(
          padding: AppSizes.horizontalPadding20,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: AppSizes.horizontalPadding20,
                  child: Image.asset(ImageConst.oggy),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    CustomButton1(
                      text: StringConst.getStarted,
                      buttonColor: ColorConst.primaryColor,
                      textColor: ColorConst.whiteColor,
                      onTap: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        Get.to(() => OnboardingPage2());
                      },
                    ),
                    SizedBox(height: AppSizes.height10 * 2.5),
                    CustomButton1(
                      text: StringConst.gotAnAccount,
                      buttonColor: ColorConst.whiteColor,
                      textColor: ColorConst.blackColor,
                      onTap: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        Get.to(() => SignInPage());
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
