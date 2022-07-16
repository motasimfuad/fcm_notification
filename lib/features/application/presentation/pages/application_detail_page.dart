import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/features/application/presentation/widgets/app_list_item.dart';

import '../../../../core/widgets/k_card.dart';
import '../../../../core/widgets/k_fab.dart';

class ApplicationDetailPage extends StatelessWidget {
  final int appId;
  const ApplicationDetailPage({
    Key? key,
    required this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: const KAppbar(
        title: 'Application Details',
      ),
      floatingActionButton: KFab(
        label: 'NEW NOTIFICATION',
        icon: Icons.notification_add_rounded,
        onPressed: () {},
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Column(
          children: [
            AppListItem(
              bgColor: KColors.secondary,
              hasOptionsBtn: false,
              titleColor: KColors.background,
              xPadding: 12.w,
              yPadding: 12.w,
              titleSize: 20.sp,
              maxLines: 3,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  'Notifications',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: KColors.primaryLight,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (BuildContext context, int index) {
                  return const NotificationItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 18.h,
      ),
      child: KCard(
        xPadding: 0.w,
        yPadding: 0.w,
        color: KColors.primary.shade600,
        radius: 20.r,
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KCard(
              xPadding: 0.w,
              yPadding: 0.w,
              radius: 20.r,
              color: KColors.primary,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Notification Name',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: KColors.primaryLight,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Last Sent: 12:00 PM',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: KColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              color: KColors.primary.shade600,
              margin: EdgeInsets.only(top: 5.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      KIconButton(
                        icon: Icons.delete_outline_rounded,
                        iconColor: KColors.danger,
                        onPressed: () {},
                      ),
                      SizedBox(width: 10.w),
                      KIconButton(
                        icon: Icons.edit_note_rounded,
                        iconColor: KColors.info,
                        onPressed: () {},
                      ),
                      SizedBox(width: 10.w),
                      KIconButton(
                        icon: Icons.copy_all_rounded,
                        iconColor: KColors.success,
                        onPressed: () {},
                      ),
                      SizedBox(width: 10.w),
                      KIconButton(
                        icon: Icons.zoom_out_map_rounded,
                        iconColor: KColors.info,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      const KIconButton(
                        // bgColor: KColors.secondary,
                        iconColor: KColors.secondary,
                      ),
                    ],
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

class KIconButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Color? bgColor;
  final Function()? onPressed;
  const KIconButton({
    Key? key,
    this.icon,
    this.iconColor,
    this.bgColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KCard(
      yPadding: 6.w,
      xPadding: 6.w,
      hasShadow: false,
      onTap: onPressed,
      color: bgColor ?? KColors.primary.shade400,
      radius: 10.r,
      child: Icon(
        icon ?? Icons.send_rounded,
        color: iconColor ?? KColors.primary.shade700,
        size: 20.w,
      ),
    );
  }
}
