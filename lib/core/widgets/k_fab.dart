import 'package:fcm_notification/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KFab extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;
  const KFab({
    Key? key,
    this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 5.h,
      ),
      child: FloatingActionButton.extended(
        elevation: 3.5,
        onPressed: onPressed,
        tooltip: label,
        backgroundColor: KColors.secondary,
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: Text(label),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
      ),
    );
  }
}
