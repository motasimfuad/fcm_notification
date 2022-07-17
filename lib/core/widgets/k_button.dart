import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

abstract class KButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? btnHeight;
  final double? btnWidth;
  final double? fontSize;

  const KButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.btnHeight,
    this.btnWidth,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bgClr = KColors.primary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: btnHeight,
        width: btnWidth,
        decoration: BoxDecoration(
          color: backgroundColor ?? bgClr,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 5.w,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KPrimaryButton extends KButton {
  KPrimaryButton({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    Color? btnColor,
    Color? textColor,
    double? btnHeight,
    bool? isDisabled,
  }) : super(
          key: key,
          onPressed: onPressed,
          text: text,
          fontSize: 17.sp,
          btnHeight: btnHeight ?? 48.h,
          btnWidth: double.infinity,
          backgroundColor: isDisabled == true ? Colors.grey : btnColor,
          textColor: isDisabled == true ? Colors.grey.shade700 : textColor,
        );
}

class KSmallButton extends KButton {
  KSmallButton({
    Key? key,
    required String text,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          text: text,
          fontSize: 18,
          btnHeight: 40,
          textColor: Colors.red,
          backgroundColor: Colors.red.shade100,
        );
}
