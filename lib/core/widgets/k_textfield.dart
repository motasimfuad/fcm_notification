import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class KTextField extends StatelessWidget {
  final String? hintText;
  final bool autofocus;
  final IconData? suffixIcon;
  final Function()? onSuffixTap;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color? bgColor;
  const KTextField({
    Key? key,
    this.hintText,
    this.autofocus = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.onSubmitted,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      textInputAction: textInputAction,
      style: TextStyle(
        color: KColors.primaryLight,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.w),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.w),
          borderSide: const BorderSide(
            color: KColors.secondary,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.w),
          borderSide: BorderSide(
            color: Colors.grey.shade700,
          ),
        ),
        filled: true,
        fillColor: bgColor ?? Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 15.h,
        ),
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixTap,
                child: Icon(
                  suffixIcon,
                  color: KColors.primary.shade200,
                ),
              )
            : null,
      ),
    );
  }
}
