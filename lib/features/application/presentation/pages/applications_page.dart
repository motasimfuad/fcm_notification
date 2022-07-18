import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/router/app_router.dart';
import 'package:fcm_notification/core/widgets/k_fab.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:fcm_notification/features/application/presentation/widgets/app_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      appBar: AppBar(
        title: const Text('FCM Notification'),
        backgroundColor: KColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            top: 15.h,
          ),
          child: BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (context, state) {
              if (state is AppListLoaded) {
                allApps = state.apps;
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ApplicationBloc>().add(GetAllAppsEvent());
                },
                child: Column(
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
                                params: {'id': 1.toString()},
                              );
                            },
                            onOptionTap: () {},
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
