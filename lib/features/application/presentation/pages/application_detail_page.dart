import 'package:fcm_notification/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/features/application/presentation/widgets/app_list_item.dart';

import '../../../../core/widgets/k_appbar.dart';
import '../../../../core/widgets/k_card.dart';
import '../../../notification/presentation/widgets/notification_item.dart';

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
      appBar: KAppbar(
        title: '',
        height: 50.h,
      ),
      // floatingActionButton: KFab(
      //   label: 'NOTIFICATION',
      //   icon: Icons.notification_add_rounded,
      //   onPressed: () {
      //     router.pushNamed(AppRouter.createNotificationPage);
      //   },
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.w,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: AppListItem(
                      bgColor: KColors.secondary,
                      hasOptionsBtn: false,
                      titleColor: KColors.background,
                      xPadding: 12.w,
                      yPadding: 12.w,
                      titleSize: 20.sp,
                      maxLines: 1,
                    ),
                  ),
                  Positioned(
                    right: 15.w,
                    bottom: 5.w,
                    child: KCard(
                      color: KColors.primary,
                      xPadding: 8.w,
                      yPadding: 8.w,
                      radius: 200,
                      hasBorder: true,
                      hasShadow: false,
                      borderColor: KColors.secondary,
                      onTap: () {
                        router.pushNamed(AppRouter.createNotificationPage);
                      },
                      child: Icon(
                        Icons.notification_add_rounded,
                        color: KColors.secondary,
                        size: 22.w,
                      ),
                    ),
                  ),
                ],
              ),
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
                    return NotificationItem(
                      key: GlobalKey(),
                      title: 'adhf adshf adfh padshfiap dosihfapdshf',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
