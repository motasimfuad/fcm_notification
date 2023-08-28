import 'package:date_time_format/date_time_format.dart';
import 'package:fcm_notification/core/constants/strings.dart';
import 'package:fcm_notification/core/router/app_router.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sweetsheet/sweetsheet.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/k_bottom_sheet.dart';
import '../../../../core/widgets/k_card.dart';
import '../../../../core/widgets/k_icon_button.dart';
import '../../domain/entities/notification_entity.dart';
import '../bloc/notification_bloc.dart';
import 'notification_type_info_widget.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  final AppEntity? app;
  final bool? isLoading;
  const NotificationItem({
    Key? key,
    required this.notification,
    this.app,
    this.isLoading,
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
                      notification.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: KColors.primaryLight,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        notification.notificationType ==
                                NotificationType.notification
                            ? const NotificationTypeInfoWidget(
                                title: 'Notification',
                                icon: Icons.notification_important_rounded,
                              )
                            : const NotificationTypeInfoWidget(
                                title: 'Data Message',
                                icon: Icons.message_rounded,
                              ),
                        SizedBox(width: 12.w),
                        notification.receiverType ==
                                NotificationReceiverType.all
                            ? const NotificationTypeInfoWidget(
                                title: 'All Users',
                                icon: Icons.alt_route_outlined,
                              )
                            : const NotificationTypeInfoWidget(
                                title: 'Single User',
                                icon: Icons.turn_slight_right_sharp,
                              ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    NotificationTypeInfoWidget(
                      title:
                          'Last Sent: ${(notification.lastSentAt != null) ? DateTimeFormat.format(notification.lastSentAt!, format: DateTimeFormats.american) : "Never"}',
                      icon: Icons.send_time_extension,
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
                        onPressed: () {
                          kBottomSheet(
                            context: context,
                            description:
                                'Do you really want to delete this notification?',
                            icon: Icons.delete_sweep_rounded,
                            positiveAction: () {
                              context.read<NotificationBloc>().add(
                                  DeleteNotificationEvent(id: notification.id));
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      SizedBox(width: 10.w),
                      KIconButton(
                        icon: Icons.edit_note_rounded,
                        iconColor: KColors.info,
                        onPressed: () {
                          router.pushNamed(
                            AppRouter.editNotificationPage,
                            pathParameters: {
                              'appId': notification.appId,
                              'notificationId': notification.id,
                            },
                          );
                        },
                      ),
                      SizedBox(width: 10.w),
                      KIconButton(
                        icon: Icons.copy_all_rounded,
                        iconColor: KColors.success,
                        onPressed: () {
                          kBottomSheet(
                            context: context,
                            title: 'Duplicate?',
                            description: 'Duplicate this notification?',
                            icon: Icons.copy_all_rounded,
                            color: SweetSheetColor.SUCCESS,
                            positiveAction: () {
                              context.read<NotificationBloc>().add(
                                  DuplicateNotificationEvent(
                                      notification: notification));
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      SizedBox(width: 10.w),
                      KIconButton(
                        icon: Icons.zoom_out_map_rounded,
                        iconColor: KColors.info,
                        onPressed: () {
                          router.pushNamed(
                            AppRouter.notificationDetailPage,
                            pathParameters: {
                              'notificationId': notification.id,
                            },
                            extra: app!.serverKey,
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      KIconButton(
                        iconColor: KColors.secondary,
                        icon: Icons.send_rounded,
                        child: isLoading == true
                            ? const CircularProgressIndicator()
                            : null,
                        onPressed: () {
                          kBottomSheet(
                            context: context,
                            title: 'Send Notification?',
                            description: Strings.sendConfirmation,
                            // icon: Icons.local_fire_department_sharp,
                            descriptionFontSize: 15.5.sp,
                            color: CustomSheetColor(
                              main: KColors.primary,
                              accent: KColors.background,
                              icon: KColors.secondary,
                            ),
                            positiveActionColor: KColors.secondary,
                            positiveTitle: 'SEND NOTIFICATION',
                            // positiveIcon: Icons.local_fire_department_sharp,
                            positiveAction: () {
                              context.read<NotificationBloc>().add(
                                    SendNotificationEvent(
                                      serverKey: app!.serverKey,
                                      notification: notification,
                                    ),
                                  );
                              Navigator.pop(context);
                            },
                          );
                        },
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
