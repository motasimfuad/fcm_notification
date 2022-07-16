import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/router/app_router.dart';
import 'package:fcm_notification/core/widgets/k_fab.dart';
import 'package:fcm_notification/features/application/presentation/widgets/app_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({Key? key}) : super(key: key);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Padding(
              //   padding: EdgeInsets.only(bottom: 20.h),
              //   child: const KTextField(
              //     suffixIcon: Icons.search_rounded,
              //     bgColor: KColors.primary,
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return AppListItem(
                      onTap: () {
                        router.pushNamed(
                          AppRouter.applicationDetailPage,
                          params: {'id': 1.toString()},
                        );
                      },
                    );
                  },
                ),
              ),
            ],
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
