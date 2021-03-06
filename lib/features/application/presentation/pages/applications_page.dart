import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/router/app_router.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_fab.dart';
import 'package:fcm_notification/core/widgets/k_refresher.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:fcm_notification/features/application/presentation/widgets/app_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/widgets/k_bottom_sheet.dart';
import '../../../notification/presentation/bloc/notification_bloc.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({Key? key}) : super(key: key);

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  List<AppEntity> allApps = [];

  @override
  void initState() {
    context.read<ApplicationBloc>().add(GetAllAppsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppbar(
        title: 'FCM Notification',
        height: 55.w,
        content: Image.asset(
          'assets/logo-horizontal.png',
          height: 30.w,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            top: 15.w,
          ),
          child: BlocConsumer<ApplicationBloc, ApplicationState>(
            listener: (context, state) {
              if (state is AppDeleted) {
                context.read<ApplicationBloc>().add(GetAllAppsEvent());
              }
            },
            builder: (context, state) {
              if (state is AppListLoaded) {
                allApps = state.apps;
                allApps.sort((a, b) => -a.createdAt.compareTo(b.createdAt));
              }

              return KRefresher(
                onRefresh: () async {
                  context.read<ApplicationBloc>().add(GetAllAppsEvent());
                },
                child: allApps.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          router.pushNamed(AppRouter.addApplicationPage);
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 65.h),
                            child: Lottie.asset(
                              'assets/animations/add-app-animation.json',
                              height: 80.w,
                              width: 80.w,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: allApps.length,
                              itemBuilder: (BuildContext context, int index) {
                                var app = allApps[index];

                                return AppListItem(
                                  app: app,
                                  onTap: () {
                                    router.pushNamed(
                                      AppRouter.applicationDetailPage,
                                      params: {'id': app.id},
                                    );
                                  },
                                  onDeleteTap: () {
                                    kBottomSheet(
                                      context: context,
                                      description:
                                          'Do you really want to delete this Application? All notifications related to this application will also be deleted.',
                                      icon: Icons.delete_sweep_rounded,
                                      positiveTitle: 'YES, DELETE IT',
                                      positiveAction: () {
                                        Navigator.pop(context);
                                        context.read<ApplicationBloc>().add(
                                              DeleteAppEvent(app.id),
                                            );
                                        context.read<NotificationBloc>().add(
                                              DeleteAppNotificationsEvent(
                                                  appId: app.id),
                                            );
                                      },
                                    );
                                  },
                                  onEditTap: () {
                                    router.pushNamed(
                                      AppRouter.applicationEditPage,
                                      params: {'id': app.id},
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: KFab(
        label: 'NEW APP',
        icon: Icons.add_to_photos_rounded,
        onPressed: () {
          router.pushNamed(AppRouter.addApplicationPage);
        },
      ),
    );
  }
}
