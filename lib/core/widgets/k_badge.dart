import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/colors.dart';

class KBadge extends StatelessWidget {
  final Widget? badgeContent;
  final String? badgeText;
  final double? textSize;
  final double? xPadding;
  final double? yPadding;
  final double? radius;
  final Color? badgeColor;
  final Color? textColor;
  const KBadge({
    Key? key,
    this.badgeContent,
    this.badgeText,
    this.textSize,
    this.xPadding,
    this.yPadding,
    this.radius,
    this.badgeColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      toAnimate: false,
      elevation: 0,
      shape: BadgeShape.square,
      badgeColor: badgeColor ?? KColors.background,
      borderRadius: BorderRadius.circular(radius ?? 15.r),
      padding: EdgeInsets.symmetric(
        horizontal: xPadding ?? 10.w,
        vertical: yPadding ?? 6.h,
      ),
      badgeContent: badgeContent ??
          Text(
            badgeText ?? '',
            style: TextStyle(
              fontSize: textSize ?? 10.sp,
              color: textColor ?? Colors.white,
            ),
          ),
    );
  }
}
