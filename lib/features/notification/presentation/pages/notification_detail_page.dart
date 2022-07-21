import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_image_container.dart';

import '../../domain/entities/notification_entity.dart';
import '../bloc/notification_bloc.dart';

class NotificationDetailPage extends StatefulWidget {
  final String id;
  const NotificationDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  NotificationEntity? notification;

  @override
  void initState() {
    context.read<NotificationBloc>().add(GetNotificationEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: const KAppbar(title: 'Notification Detail'),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NotificationLoaded) {
            notification = state.notification;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                NotificationDetailItem(
                  label: 'Notification Name',
                  value: notification?.name,
                ),
                NotificationDetailItem(
                  label: 'Topic Name',
                  value: notification?.topicName,
                ),
                NotificationDetailItem(
                  label: 'Device ID',
                  value: notification?.deviceId,
                ),
                (notification?.topicName != null &&
                        notification!.topicName!.isNotEmpty)
                    ? buildNotificationFields()
                    : const SizedBox(),
                // SizedBox(height: 20.w),
                (notification?.deviceId != null &&
                        notification!.deviceId!.isNotEmpty)
                    ? buildDataMessageFields()
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
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

class NotificationDetailItem extends StatelessWidget {
  final String? label;
  final String? value;
  final bool? hasBottomMargin;
  final Color? bgColor;
  final bool? showItem;
  const NotificationDetailItem({
    Key? key,
    this.label,
    this.value,
    this.hasBottomMargin = true,
    this.bgColor,
    this.showItem = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (value != null && value!.isNotEmpty)
        ? Column(
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
                padding: EdgeInsets.only(
                  bottom: (hasBottomMargin == false) ? 0 : 20.w,
                ),
                child: KCard(
                  color: bgColor ?? KColors.primary,
                  radius: 15.r,
                  yPadding: 0.w,
                  xPadding: 0.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 13.w,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            value ?? 'Not Available',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: KColors.primary.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
