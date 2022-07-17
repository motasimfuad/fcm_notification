import 'package:fcm_notification/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/k_card.dart';
import '../../../../core/widgets/k_icon_button.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String? lastSent;
  const NotificationItem({
    Key? key,
    required this.title,
    this.lastSent,
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
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: KColors.primaryLight,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Last Sent: ${lastSent ?? 'Never'}',
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
                horizontal: 13.w,
                vertical: 12.w,
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
                        onPressed: () {
                          //! Implement later
                          router.pushNamed(
                            AppRouter.notificationDetailPage,
                            params: {
                              'notificationId': 10.toString(),
                            },
                          );
                        },
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
