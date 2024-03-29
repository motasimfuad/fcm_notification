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
  static const String applicationEditPage = 'edit-app';
  static const String createNotificationPage = 'create-notification';
  static const String editNotificationPage = 'edit-notification';
  static const String notificationDetailPage = 'notification-details';
}

final router = GoRouter(
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

    // Add Application Page
    GoRoute(
      name: AppRouter.addApplicationPage,
      path: '/${AppRouter.addApplicationPage}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const AddAppPage(id: null),
        );
      },
    ),

    // application edit page
    GoRoute(
      name: AppRouter.applicationEditPage,
      path: '/${AppRouter.applicationEditPage}/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'];
        return MaterialPage(
          key: state.pageKey,
          child: AddAppPage(id: id),
        );
      },
    ),

    // application detail page
    GoRoute(
      name: AppRouter.applicationDetailPage,
      path: '/${AppRouter.applicationDetailPage}:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'];

        return MaterialPage(
          key: state.pageKey,
          child: ApplicationDetailPage(
            appId: id,
          ),
        );
      },
    ),

    // notification detail page
    GoRoute(
      name: AppRouter.notificationDetailPage,
      path: '/${AppRouter.notificationDetailPage}:notificationId',
      pageBuilder: (context, state) {
        final notificationId = state.pathParameters['notificationId'];

        return MaterialPage(
          key: state.pageKey,
          child: NotificationDetailPage(
            id: notificationId.toString(),
            serverKey: state.extra as String?,
          ),
        );
      },
    ),

    // notification edit on create page
    GoRoute(
      name: AppRouter.editNotificationPage,
      path: '/:appId/${AppRouter.editNotificationPage}:notificationId',
      pageBuilder: (context, state) {
        final appId = state.pathParameters['appId'];
        final notificationId = state.pathParameters['notificationId'];

        return MaterialPage(
          key: state.pageKey,
          child: CreateNotificationPage(
            appId: appId.toString(),
            notificationId: notificationId,
          ),
        );
      },
    ),

    // create notification page
    GoRoute(
      name: AppRouter.createNotificationPage,
      path: '/:appId/${AppRouter.createNotificationPage}',
      pageBuilder: (context, state) {
        final appId = state.pathParameters['appId'];

        return MaterialPage(
          key: state.pageKey,
          child: CreateNotificationPage(appId: appId.toString()),
        );
      },
    ),
  ],
);
