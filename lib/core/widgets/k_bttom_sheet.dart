import 'package:fcm_notification/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sweetsheet/sweetsheet.dart';

// final SweetSheet sweetSheet = SweetSheet();

kBottomSheet({
  String? title,
  String? description,
  CustomSheetColor? color,
  String? positiveTitle,
  String? negativeTitle,
  Function()? positiveAction,
  IconData? icon,
  required BuildContext context,
}) {
  getIt<SweetSheet>().show(
    context: context,
    title: Text(title ?? "Attention"),
    description: Text(description ?? 'Please Confirm!'),
    color: color ?? SweetSheetColor.DANGER,
    icon: icon,
    positive: SweetSheetAction(
      onPressed: positiveAction ??
          () {
            Navigator.of(context).pop();
          },
      title: positiveTitle ?? 'CONFIRM',
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
