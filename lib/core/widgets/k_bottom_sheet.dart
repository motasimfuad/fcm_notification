import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sweetsheet/sweetsheet.dart';

// final SweetSheet sweetSheet = SweetSheet();

kBottomSheet({
  String? title,
  String? description,
  double? descriptionFontSize,
  CustomSheetColor? color,
  String? positiveTitle,
  String? negativeTitle,
  Function()? positiveAction,
  IconData? icon,
  IconData? positiveIcon,
  Color? positiveActionColor,
  required BuildContext context,
}) {
  getIt<SweetSheet>().show(
    context: context,
    title: Text(
      title ?? "Attention!",
      style: TextStyle(
        fontSize: 22.sp,
        color: KColors.primary.shade50,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.start,
    ),
    description: Text(
      description ?? 'Please Confirm!',
      style: TextStyle(
        fontSize: descriptionFontSize ?? 18.sp,
        color: KColors.primary.shade50,
      ),
      textAlign: TextAlign.start,
    ),
    color: color ?? SweetSheetColor.DANGER,
    icon: icon,
    positive: SweetSheetAction(
      onPressed: positiveAction ??
          () {
            Navigator.of(context).pop();
          },
      title: positiveTitle ?? 'CONFIRM',
      icon: positiveIcon,
      color: positiveActionColor ?? Colors.white,
    ),
    negative: SweetSheetAction(
      onPressed: () {
        Navigator.of(context).pop();
      },
      title: negativeTitle ?? 'CANCEL',
    ),
    actionPadding: EdgeInsets.symmetric(
      horizontal: 10.w,
      vertical: 5.w,
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 20.w,
      vertical: 20.w,
    ),
  );
}
