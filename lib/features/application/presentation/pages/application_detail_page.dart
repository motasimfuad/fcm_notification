import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/router/app_router.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:fcm_notification/features/application/presentation/widgets/app_list_item.dart';

import '../../../../core/widgets/k_appbar.dart';
import '../../../../core/widgets/k_fab.dart';
import '../../../../core/widgets/k_refresher.dart';
import '../../../../core/widgets/k_snack_bar.dart';
import '../../../notification/domain/entities/notification_entity.dart';
import '../../../notification/presentation/bloc/notification_bloc.dart';
import '../../../notification/presentation/widgets/notification_item.dart';
import '../widgets/empty_notifications_widget.dart';

class ApplicationDetailPage extends StatefulWidget {
  final String? appId;
  const ApplicationDetailPage({
    Key? key,
    required this.appId,
  }) : super(key: key);

  @override
  State<ApplicationDetailPage> createState() => _ApplicationDetailPageState();
}

class _ApplicationDetailPageState extends State<ApplicationDetailPage> {
  AppEntity? app;
  List<NotificationEntity>? notifications = [];

  @override
  void initState() {
    context.read<ApplicationBloc>().add(GetAppEvent(widget.appId!));
    context
        .read<NotificationBloc>()
        .add(GetAppNotificationsEvent(appId: widget.appId!));
    super.initState();
  }

  bool notificationListIsEmpty() {
    return (notifications == null || notifications!.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppbar(
        title: '',
        height: 50.h,
      ),
      floatingActionButton: KFab(
        label: 'NOTIFICATION',
        icon: Icons.notification_add_rounded,
        onPressed: () {
          router.pushNamed(
            AppRouter.createNotificationPage,
            params: {'appId': app!.id},
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.w,
          ),
          child: BlocConsumer<ApplicationBloc, ApplicationState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AppLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }

              if (state is AppLoaded) {
                app = state.app;
                context.read<ApplicationBloc>().add(GetAllAppsEvent());
              }
              if (state is AppUpdatedState) {
                context.read<ApplicationBloc>().add(GetAppEvent(widget.appId!));
              }

              return Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 0.h),
                        child: AppListItem(
                          app: app,
                          bgColor: KColors.secondary,
                          hasOptionsBtn: false,
                          titleColor: KColors.background,
                          xPadding: 12.w,
                          yPadding: 12.w,
                          titleSize: 20.sp,
                          maxLines: 1,
                          bottomMargin: 0,
                        ),
                      ),
                      // notificationListIsEmpty()
                      //     ? const SizedBox()
                      //     : Positioned(
                      //         right: 15.w,
                      //         bottom: 5.w,
                      //         child: NewNotificationIcon(
                      //           onTap: () {
                      //             router.pushNamed(
                      //               AppRouter.createNotificationPage,
                      //               params: {'appId': app!.id},
                      //             );
                      //           },
                      //         ),
                      //       ),
                    ],
                  ),
                  notificationListIsEmpty()
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(bottom: 15.h, top: 20.h),
                          child: Row(
                            children: [
                              Text(
                                'Notifications',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: KColors.primaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                  BlocConsumer<NotificationBloc, NotificationState>(
                    listener: (context, state) {
                      if (state is NotificationListLoaded) {
                        notifications = state.notifications;
                        notifications?.sort(
                            (a, b) => -a.createdAt.compareTo(b.createdAt));

                        // update the app entity
                        if (app != null) {
                          AppEntity updateAppEntity = AppEntity(
                            id: app!.id,
                            name: app!.name,
                            serverKey: app!.serverKey,
                            iconName: app!.iconName,
                            createdAt: app!.createdAt,
                            notifications: notifications,
                          );
                          context
                              .read<ApplicationBloc>()
                              .add(UpdateAppEvent(updateAppEntity));
                        }
                      }
                      if (state is NotificationDeletedState) {
                        kSnackBar(
                          context: context,
                          type: AlertType.success,
                          message: 'Notification deleted successfully!',
                        );
                        context.read<NotificationBloc>().add(
                            GetAppNotificationsEvent(appId: widget.appId!));
                      }
                      if (state is NotificationDuplicatedState) {
                        kSnackBar(
                          context: context,
                          type: AlertType.success,
                          message: 'Notification duplicated successfully!',
                        );
                        context.read<NotificationBloc>().add(
                            GetAppNotificationsEvent(appId: widget.appId!));
                      }
                    },
                    builder: (context, state) {
                      return Expanded(
                        child: KRefresher(
                          onRefresh: () async {
                            context.read<NotificationBloc>().add(
                                  GetAppNotificationsEvent(
                                    appId: app!.id,
                                  ),
                                );
                          },
                          child: notificationListIsEmpty()
                              ? const EmptyNotificationsWidget()
                              : ListView.builder(
                                  itemCount: notifications!.length,
                                  primary: false,
                                  padding: EdgeInsets.only(bottom: 70.h),
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final singleNotification =
                                        notifications![index];

                                    return NotificationItem(
                                      key: GlobalKey(),
                                      notification: singleNotification,
                                    );
                                  },
                                ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
