import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

export 'package:flash/flash.dart';

enum AlertType { success, failed, warning, info, notImplemented }

kSnackBar({
  required BuildContext context,
  AlertType type = AlertType.notImplemented,
  String? message,
  bool? isDismissible = true,
  int? durationSeconds,
  bool? takeRequired,
  bool? showActionButton = false,
  bool? showProgress = false,
  bool? showSideIndicator = true,
  IconData? icon,
  Function()? onActionButtonTap,
  String? actionButtonText,
  Color? iconColor,
  FlashPosition? position,
  bool? showIcon = true,
}) {
  showFlash(
    context: context,
    duration: Duration(seconds: durationSeconds ?? 3),
    persistent: true,
    builder: (_, controller) {
      return Flash(
        controller: controller,
        position: position ?? FlashPosition.top,
        forwardAnimationCurve: Curves.easeInOutCubic,
        reverseAnimationCurve: Curves.easeOutQuint,
        dismissDirections: isDismissible == true
            ? const [
                FlashDismissDirection.startToEnd,
                FlashDismissDirection.endToStart,
              ]
            : [],
        child: FlashBar(
          controller: controller,
          useSafeArea: true,
          margin: EdgeInsets.all(20.h),
          behavior: FlashBehavior.floating,
          backgroundColor: generateBgColor(type),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          showProgressIndicator: showProgress == true ? true : false,
          content: Text(
            message ?? generateText(type),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          indicatorColor:
              showSideIndicator == true ? generateIndicatorColor(type) : null,
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          icon: showIcon == true
              ? Icon(
                  icon ?? generateIcon(type),
                  color: iconColor ?? Colors.white,
                  size: 26.w,
                )
              : null,
          primaryAction: showActionButton == true || isDismissible == false
              ? GestureDetector(
                  onTap: onActionButtonTap,
                  child: AbsorbPointer(
                    absorbing: onActionButtonTap == null ? true : false,
                    child: GestureDetector(
                      onTap: () async {
                        onActionButtonTap!();
                        await controller.dismiss();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 8.w,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 4.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: generateIndicatorColor(type),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          actionButtonText ?? 'Close',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
      );
    },
  );
}

// color of the snackbar
Color? generateBgColor(AlertType type) {
  switch (type) {
    case AlertType.success:
      return Colors.green;
    case AlertType.failed:
      return Colors.red.shade700;
    case AlertType.warning:
      return KColors.warning;
    case AlertType.info:
      return KColors.primary;
    case AlertType.notImplemented:
      return Colors.black;
    default:
      return KColors.primary.shade700;
  }
}

// color of the items
Color? generateItemColor(AlertType type) {
  switch (type) {
    default:
      return Colors.white;
  }
}

// color of the Indicator
Color? generateIndicatorColor(AlertType type) {
  switch (type) {
    case AlertType.success:
      return Colors.green.shade900;
    case AlertType.failed:
      return KColors.primary;
    case AlertType.warning:
      return Colors.orange.shade800;
    case AlertType.info:
      return KColors.primary.shade900;
    case AlertType.notImplemented:
      return KColors.danger;
    default:
      return KColors.primary.shade700;
  }
}

//text of the snackbar
generateText(AlertType type) {
  switch (type) {
    case AlertType.success:
      return "Success!";
    case AlertType.failed:
      return "Failed!";
    case AlertType.warning:
      return "Warning!";
    case AlertType.info:
      return "Info!";
    case AlertType.notImplemented:
      return "Not Yet Implemented!";
    default:
      return 'Alert';
  }
}

// icon of the snackbar
generateIcon(AlertType type) {
  switch (type) {
    case AlertType.success:
      return Icons.check_circle_outline_outlined;
    case AlertType.failed:
      return Icons.highlight_off_outlined;
    case AlertType.info:
      return Icons.info_outline_rounded;
    case AlertType.warning:
      return Icons.warning_amber_rounded;
    case AlertType.notImplemented:
      return Icons.motion_photos_pause_outlined;
    default:
      return Icons.info_outline_rounded;
  }
}
