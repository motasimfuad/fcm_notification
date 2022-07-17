import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/colors.dart';

class KFab extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;
  final bool? isDisabled;
  const KFab({
    Key? key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isDisabled ?? false,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 5.h,
        ),
        child: FloatingActionButton.extended(
          elevation: 3.5,
          onPressed: onPressed,
          tooltip: label,
          backgroundColor: isDisabled == true ? Colors.grey : KColors.secondary,
          foregroundColor:
              isDisabled == true ? Colors.grey.shade700 : KColors.primary,
          icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
          label: Text(label),
          extendedTextStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
        ),
      ),
    );
  }
}
