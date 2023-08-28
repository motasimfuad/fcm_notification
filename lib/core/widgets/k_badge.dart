import 'package:badges/badges.dart' as badges;
import 'package:fcm_notification/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KBadge extends StatelessWidget {
  final Widget? badgeContent;
  final String? badgeText;
  final double? textSize;
  final double? xPadding;
  final double? yPadding;
  final double? radius;
  final Color? badgeColor;
  final Color? textColor;
  final FontWeight? fontWeight;
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
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeAnimation: const badges.BadgeAnimation.scale(
        toAnimate: false,
      ),
      badgeStyle: badges.BadgeStyle(
        elevation: 0,
        shape: badges.BadgeShape.square,
        badgeColor: badgeColor ?? KColors.background,
        padding: EdgeInsets.symmetric(
          horizontal: xPadding ?? 10.w,
          vertical: yPadding ?? 6.h,
        ),
        borderRadius: BorderRadius.circular(radius ?? 15.r),
      ),
      badgeContent: badgeContent ??
          Text(
            badgeText ?? '',
            style: TextStyle(
              fontSize: textSize ?? 10.sp,
              color: textColor ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ),
    );
  }
}
