import 'package:flutter/material.dart';
import 'package:oggy/const/color_const.dart';
import 'package:oggy/utils/app_sizes.dart';

class CustomButton2 extends StatelessWidget {
  const CustomButton2({
    Key? key,
    required this.text,
    required this.image,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  final String text, image;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: AppSizes.height10 * 4.5,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ColorConst.greyColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.height10, horizontal: AppSizes.width10 * 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(image, height: AppSizes.height10 * 2),
              SizedBox(width: AppSizes.width10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConst.blackColor,
                  fontSize: AppSizes.height10 * 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
