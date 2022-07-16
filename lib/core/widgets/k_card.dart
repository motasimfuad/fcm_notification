import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class KCard extends StatelessWidget {
  final String? title;
  final double? height;
  final double? minHeight;
  final double? maxHeight;
  final double? width;
  final double? xPadding;
  final double? yPadding;
  final double? xMargin;
  final double? yMargin;
  final double? radius;
  final Color? color;
  final bool? hasShadow;
  final bool? hasBorder;
  final Color? borderColor;
  final double? borderWidth;
  final Function()? onTap;
  final Widget? child;
  const KCard({
    Key? key,
    this.title,
    this.height,
    this.minHeight,
    this.maxHeight,
    this.width,
    this.xPadding,
    this.yPadding,
    this.xMargin,
    this.yMargin,
    this.radius,
    this.color,
    this.hasShadow = true,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        constraints: BoxConstraints(
          minHeight: minHeight ?? 0.0,
          maxHeight: maxHeight ?? double.infinity,
        ),
        padding: EdgeInsets.symmetric(
          vertical: yPadding ?? 8.w,
          horizontal: xPadding ?? 8.w,
        ),
        margin: EdgeInsets.symmetric(
          vertical: yMargin ?? 0.0,
          horizontal: xMargin ?? 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 26.r),
          color: color ?? KColors.primary.shade200,
          border: hasBorder == true
              ? Border.all(
                  color: borderColor ?? Colors.black,
                  width: borderWidth ?? 3,
                )
              : null,
          boxShadow: hasShadow == true
              ? [
                  BoxShadow(
                    offset: Offset(0.w, 3.h),
                    color: Colors.black12,
                    blurRadius: 2.5.w,
                    spreadRadius: 0.w,
                  )
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          clipBehavior: Clip.antiAlias,
          child: child ??
              Text(
                title ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
        ),
      ),
    );
  }
}
