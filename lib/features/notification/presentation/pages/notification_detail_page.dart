import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';

class NotificationDetailPage extends StatelessWidget {
  final int id;
  const NotificationDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: const KAppbar(title: 'Notification Detail'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            const NotificationDetailItem(
              label: 'Notification Name',
            ),
            const NotificationDetailItem(
              label: 'Topic Name',
            ),
            const NotificationDetailItem(
              label: 'Device ID',
            ),
            KCard(
              yPadding: 15.w,
              xPadding: 12.w,
              color: KColors.primary,
              child: Column(
                children: [
                  NotificationDetailItem(
                    label: 'Title',
                    bgColor: KColors.background,
                  ),
                  NotificationDetailItem(
                    label: 'Body',
                    bgColor: KColors.background,
                    hasBottomMargin: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.w),
            KCard(
              yPadding: 15.w,
              xPadding: 12.w,
              color: KColors.primary,
              child: Row(
                children: [
                  Expanded(
                    child: NotificationDetailItem(
                      label: 'Key',
                      bgColor: KColors.background,
                      hasBottomMargin: false,
                    ),
                  ),
                  Text(
                    ' : ',
                    style: TextStyle(
                      color: KColors.background,
                      fontSize: 20.sp,
                    ),
                  ),
                  Expanded(
                    child: NotificationDetailItem(
                      label: 'Value',
                      bgColor: KColors.background,
                      hasBottomMargin: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationDetailItem extends StatelessWidget {
  final String? label;
  final bool? hasBottomMargin;
  final Color? bgColor;
  const NotificationDetailItem({
    Key? key,
    this.label,
    this.hasBottomMargin = true,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        label != null
            ? Padding(
                padding: EdgeInsets.only(left: 10.w, bottom: 6.w),
                child: Row(
                  children: [
                    Text(
                      label ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: KColors.primary.shade300,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        Padding(
          padding:
              EdgeInsets.only(bottom: (hasBottomMargin == false) ? 0 : 20.h),
          child: KCard(
            color: bgColor ?? KColors.primary,
            radius: 20.r,
            yPadding: 0.w,
            xPadding: 0.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 13.w,
              ),
              child: Text(
                'Content hadsfp0 adfh audhsf apdfhapdshfu apdsfh pads adsfhjp adhsfp',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: KColors.primary.shade300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
