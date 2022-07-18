import 'package:fcm_notification/features/application/presentation/pages/add_app_page.dart';
import 'package:fcm_notification/features/application/presentation/pages/application_detail_page.dart';
import 'package:fcm_notification/features/application/presentation/pages/applications_page.dart';
import 'package:fcm_notification/features/notification/presentation/pages/create_notification_page.dart';
import 'package:fcm_notification/features/notification/presentation/pages/notification_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String homePage = '/';
  static const String addApplicationPage = 'add-application';
  static const String applicationDetailPage = 'app-details';
  static const String createNotificationPage = 'create-notification';
  static const String notificationDetailPage = 'notification-details';
}

final router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: AppRouter.homePage,
  routes: [
    GoRoute(
      name: AppRouter.homePage,
      path: AppRouter.homePage,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const ApplicationsPage(),
        );
      },
    ),
    GoRoute(
      name: AppRouter.addApplicationPage,
      path: '/${AppRouter.addApplicationPage}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const AddAppPage(),
        );
      },
    ),
    GoRoute(
      name: AppRouter.applicationDetailPage,
      path: '/${AppRouter.applicationDetailPage}:id',
      pageBuilder: (context, state) {
        print(state.params);
        final id = state.params['id'];

        return MaterialPage(
          key: state.pageKey,
          child: ApplicationDetailPage(
            appId: id,
          ),
        );
      },
    ),
    GoRoute(
      name: AppRouter.notificationDetailPage,
      path: '/${AppRouter.notificationDetailPage}:notificationId',
      pageBuilder: (context, state) {
        final notificationId = state.params['notificationId'];

        return MaterialPage(
          key: state.pageKey,
          child: NotificationDetailPage(
            id: int.parse(notificationId.toString()),
          ),
        );
      },
    ),
    GoRoute(
      name: AppRouter.createNotificationPage,
      path: '/${AppRouter.createNotificationPage}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const CreateNotificationPage(),
        );
      },
    ),
  ],
);
