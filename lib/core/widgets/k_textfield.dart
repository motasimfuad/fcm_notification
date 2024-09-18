import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class KTextField extends StatelessWidget {
  final String? hintText;
  final bool autofocus;
  final bool? hasLabel;
  final IconData? suffixIcon;
  final Function()? onSuffixTap;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color? bgColor;
  final int? maxLines;
  final double? bottomPadding;
  final bool isReadOnly;
  const KTextField({
    Key? key,
    this.hintText,
    this.autofocus = false,
    this.hasLabel = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.onSubmitted,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.bgColor,
    this.maxLines,
    this.bottomPadding,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        hasLabel == true
            ? Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Text(
                      hintText ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: KColors.primary.shade300,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        Padding(
          padding: EdgeInsets.only(
            bottom: bottomPadding ?? 20.h,
          ),
          child: TextFormField(
            autofocus: autofocus,
            controller: controller,
            cursorColor: KColors.secondary,
            onChanged: onChanged,
            focusNode: focusNode,
            onFieldSubmitted: onSubmitted,
            validator: validator,
            textInputAction: textInputAction ?? TextInputAction.next,
            style: TextStyle(
              color: KColors.primaryLight,
            ),
            readOnly: isReadOnly,
            enabled: !isReadOnly,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: KColors.primary.shade300,
              ),
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
              fillColor: bgColor ?? KColors.primary,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 16.h,
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
          ),
        ),
      ],
    );
  }
}
