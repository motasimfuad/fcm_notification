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
import '../../../notification/presentation/widgets/notification_item.dart';
import '../widgets/new_notification_icon.dart';

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

  @override
  void initState() {
    context.read<ApplicationBloc>().add(GetAppEvent(widget.appId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppbar(
        title: '',
        height: 50.h,
      ),
      floatingActionButton:
          (app?.notifications == null || app!.notifications!.isEmpty)
              ? KFab(
                  label: 'NOTIFICATION',
                  icon: Icons.notification_add_rounded,
                  onPressed: () {
                    router.pushNamed(
                      AppRouter.createNotificationPage,
                      params: {'appId': app!.id},
                    );
                  },
                )
              : null,
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
              }

              return Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: AppListItem(
                          app: app,
                          bgColor: KColors.secondary,
                          hasOptionsBtn: false,
                          titleColor: KColors.background,
                          xPadding: 12.w,
                          yPadding: 12.w,
                          titleSize: 20.sp,
                          maxLines: 1,
                        ),
                      ),
                      (app?.notifications != null &&
                              app!.notifications!.isNotEmpty)
                          ? Positioned(
                              right: 15.w,
                              bottom: 5.w,
                              child: NewNotificationIcon(
                                onTap: () {
                                  router.pushNamed(
                                    AppRouter.createNotificationPage,
                                    params: {'appId': app!.id},
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  (app?.notifications != null && app!.notifications!.isNotEmpty)
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
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
                        )
                      : const SizedBox(),
                  Expanded(
                    child: KRefresher(
                      onRefresh: () async {},
                      child: (app?.notifications != null &&
                              app!.notifications!.isNotEmpty)
                          ? ListView.builder(
                              itemCount: 0,
                              primary: false,
                              physics: const AlwaysScrollableScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemBuilder: (BuildContext context, int index) {
                                return NotificationItem(
                                  key: GlobalKey(),
                                  title:
                                      'adhf adshf adfh padshfiap dosihfapdshf',
                                );
                              },
                            )
                          : Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'No notifications found!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: KColors.primaryLight,
                                      ),
                                    ),
                                    SizedBox(height: 50.h),
                                  ],
                                ),
                                ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                ),
                              ],
                            ),
                    ),
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
