import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sweetsheet/sweetsheet.dart';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/constants/enums.dart';
import 'package:fcm_notification/core/router/app_router.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_image_container.dart';
import 'package:fcm_notification/features/notification/presentation/widgets/notification_fab_menu.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/widgets/k_bottom_sheet.dart';
import '../../domain/entities/notification_entity.dart';
import '../bloc/notification_bloc.dart';
import '../widgets/notification_detail_item.dart';
import '../widgets/notification_type_info_widget.dart';

class NotificationDetailPage extends StatefulWidget {
  final String id;
  final String? serverKey;
  const NotificationDetailPage({
    Key? key,
    required this.id,
    this.serverKey,
  }) : super(key: key);

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  NotificationEntity? notification;

  @override
  void initState() {
    print("widget.serverKey: ${widget.serverKey}");
    context.read<NotificationBloc>().add(GetNotificationEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: const KAppbar(title: 'Notification Detail'),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: NotificationFabMenu(
          onTapDelete: () {
            notificationDeleteMethod(context);
          },
          onTapDuplicate: () {
            notificationDuplicateMethod(context);
          },
          onTapEdit: () {
            router.pushNamed(
              AppRouter.editNotificationPage,
              params: {
                'appId': notification!.appId,
                'notificationId': notification!.id,
              },
            );
          },
          onTapSend: () {
            kBottomSheet(
              context: context,
              title: 'Send Notification?',
              description: Strings.sendConfirmation,
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
                        serverKey: widget.serverKey!,
                        notification: notification!,
                      ),
                    );
                Navigator.pop(context);
              },
            );
          },
          child: BlocConsumer<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state is NotificationEditedState) {
                context
                    .read<NotificationBloc>()
                    .add(GetNotificationEvent(id: widget.id));
              }
            },
            builder: (context, state) {
              if (state is NotificationLoadedState) {
                notification = state.notification;
              }

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  bottom: 100.w,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: NotificationTypeInfoWidget(
                        title:
                            'Last Sent: ${(notification?.lastSentAt != null) ? DateTimeFormat.format(notification!.lastSentAt!, format: DateTimeFormats.american) : "Never"}',
                        // icon: Icons.send_time_extension,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    NotificationDetailItem(
                      label: 'Notification Name',
                      value: notification?.name,
                    ),
                    (notification?.receiverType == NotificationReceiverType.all)
                        ? NotificationDetailItem(
                            label: 'Topic Name',
                            value: notification?.topicName,
                          )
                        : NotificationDetailItem(
                            label: 'Device ID',
                            value: notification?.deviceId,
                          ),
                    (notification?.notificationType ==
                            NotificationType.notification)
                        ? buildNotificationFields()
                        : buildDataMessageFields(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void notificationDuplicateMethod(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    kBottomSheet(
      context: context,
      title: 'Duplicate?',
      description: 'Duplicate this notification?',
      icon: Icons.copy_all_rounded,
      color: SweetSheetColor.SUCCESS,
      positiveAction: () {
        context
            .read<NotificationBloc>()
            .add(DuplicateNotificationEvent(notification: notification!));
        Navigator.pop(context);
        router.pop();
      },
    );
  }

  void notificationDeleteMethod(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    kBottomSheet(
      context: context,
      description: 'Do you really want to delete this notification?',
      icon: Icons.delete_sweep_rounded,
      positiveAction: () {
        context
            .read<NotificationBloc>()
            .add(DeleteNotificationEvent(id: notification!.id));
        Navigator.pop(context);
        router.pop();
      },
    );
  }

  KCard buildNotificationFields() {
    return KCard(
      xPadding: 15.w,
      yPadding: 0,
      color: KColors.primary,
      child: Padding(
        padding: EdgeInsets.only(top: 20.w),
        child: Column(
          children: [
            NotificationDetailItem(
              label: 'Title',
              bgColor: KColors.background,
              value: notification?.title,
            ),
            NotificationDetailItem(
              label: 'Body',
              bgColor: KColors.background,
              value: notification?.body,
            ),
            NotificationDetailItem(
              label: 'ImageUrl',
              bgColor: KColors.background,
              value: notification?.imageUrl,
            ),
            (notification?.imageUrl != null &&
                    notification!.imageUrl!.isNotEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Image Preview',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: KColors.primary.shade300,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.w),
                              Text(
                                'Image will be only shown if the internet is available!',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: KColors.primary.shade300,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.w),
                        child: KImageContainer(
                          imageUrl: '${notification?.imageUrl}',
                          imageType: ImageType.network,
                          height: 180.h,
                          hasBorder: true,
                          borderClr: KColors.background,
                          fallBackText:
                              'Image Not Available\nImage could not be loaded 😢',
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  KCard buildDataMessageFields() {
    return KCard(
      xPadding: 15.w,
      yPadding: 0,
      color: KColors.primary,
      child: Padding(
        padding: EdgeInsets.only(top: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: NotificationDetailItem(
                label: 'Key',
                bgColor: KColors.background,
                value: notification?.dataKey,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: NotificationDetailItem(
                label: 'Value',
                bgColor: KColors.background,
                value: notification?.dataValue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
