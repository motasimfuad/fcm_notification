import 'package:fcm_notification/features/application/presentation/pages/add_app_page.dart';
import 'package:fcm_notification/features/application/presentation/pages/applications_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String homePage = '/';
  static const String addApplicationPage = 'add-application';
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
  ],
);
