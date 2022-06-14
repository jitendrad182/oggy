import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oggy/const/color_const.dart';
import 'package:oggy/const/string_const.dart';
import 'package:oggy/controllers/create_profile_controller.dart';
import 'package:oggy/utils/app_sizes.dart';
import 'package:oggy/utils/no_leading_space_formatter.dart';
import 'package:oggy/utils/no_leading_trailing_space_formatter.dart';
import 'package:oggy/views/pages/onboarding/avatar_choose_page.dart';
import 'package:oggy/views/widgets/custom_app_bars/custom_app_bar_1.dart';
import 'package:oggy/views/widgets/custom_buttons/custom_button_1.dart';
import 'package:oggy/views/widgets/custom_text_form_fields/custom_text_form_field_1.dart';
import 'package:oggy/views/widgets/custom_titles/custom_title_1.dart';

class OnboardingPage2 extends StatelessWidget {
  OnboardingPage2({Key? key}) : super(key: key);

  final _controller = Get.put(CreateProfileController());

  @override
  Widget build(BuildContext context) {
    AppSizes.mediaQueryHeightWidth();
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      appBar: appBar1,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          reverse: true,
          child: Padding(
            padding: AppSizes.padding20,
            child: Column(
              children: [
                const CustomTitle1(text: StringConst.createProfile),
                SizedBox(height: AppSizes.height10 * 4),
                GestureDetector(
                  child: Stack(
                    children: [
                      Center(
                        child: Obx(
                          () => Image.asset(
                            _controller.avatarImageConst(),
                            height: AppSizes.height10 * 10,
                          ),
                        ),
                      ),
                      Positioned(
                        left: AppSizes.width10 * 20.5,
                        top: AppSizes.height10 * 6.7,
                        child: CircleAvatar(
                          backgroundColor: ColorConst.primaryColor,
                          radius: AppSizes.height10 * 1.5,
                          child: Icon(
                            Icons.create_rounded,
                            size: AppSizes.height10 * 2,
                            color: ColorConst.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    Get.to(() => AvatarChoosePage());
                  },
                ),
                SizedBox(height: AppSizes.height10 * 2),
                Form(
                  key: _controller.key,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextFormField1(
                        controller: _controller.nameController,
                        maxLines: 1,
                        hintText: StringConst.enterYourName,
                        validator: (val) {
                          if (GetUtils.isLengthGreaterOrEqual(val!, 4)) {
                            return null;
                          } else {
                            return StringConst.enterValidName;
                          }
                        },
                        keyboardType: TextInputType.name,
                        inputFormatters: [NoLeadingSpaceFormatter()],
                        obscureText: false,
                      ),
                      SizedBox(height: AppSizes.height10 * 2),
                      CustomTextFormField1(
                        controller: _controller.numberController,
                        maxLines: 1,
                        hintText: StringConst.enterYourMobileNumber,
                        validator: (val) {
                          if (GetUtils.isPhoneNumber(val!) &
                              GetUtils.isLengthEqualTo(val, 10)) {
                            return null;
                          } else {
                            return StringConst.enterValidMobileNumber;
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [NoLeadingTrailingSpaceFormatter()],
                        obscureText: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.height10 * 4),
                CustomButton1(
                  text: StringConst.continueButtonString,
                  buttonColor: ColorConst.primaryColor,
                  textColor: ColorConst.whiteColor,
                  onTap: () {
                    _controller.onTap(context);
                  },
                ),
                SizedBox(height: AppSizes.height10 * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
