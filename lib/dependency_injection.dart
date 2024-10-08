import 'package:fcm_notification/core/constants/strings.dart';
import 'package:fcm_notification/features/application/data/repositories/app_repository_impl.dart';
import 'package:fcm_notification/features/application/domain/repositories/app_repository.dart';
import 'package:fcm_notification/features/application/domain/usecases/create_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/delete_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/get_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/update_app_usecase.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:fcm_notification/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:fcm_notification/features/notification/data/models/data_model.dart';
import 'package:fcm_notification/features/notification/data/repositories/notification_repositiory_impl.dart';
import 'package:fcm_notification/features/notification/domain/repositories/notification_repository.dart';
import 'package:fcm_notification/features/notification/domain/usecases/delete_app_notifications_usecase.dart';
import 'package:fcm_notification/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sweetsheet/sweetsheet.dart';

import 'core/constants/enums.dart';
import 'core/services/dio_client.dart';
import 'features/application/data/datasources/app_local_datasource.dart';
import 'features/application/data/models/app_model.dart';
import 'features/application/domain/usecases/get_all_apps_usecase.dart';
import 'features/notification/data/datasources/notification_local_datasource.dart';
import 'features/notification/data/models/notification_model.dart';
import 'features/notification/domain/usecases/create_notification_usecase.dart';
import 'features/notification/domain/usecases/delete_notification_usecase.dart';
import 'features/notification/domain/usecases/get_app_notifications_usecase.dart';
import 'features/notification/domain/usecases/get_notification_usecase.dart';
import 'features/notification/domain/usecases/send_notification_usecase.dart';
import 'features/notification/domain/usecases/update_notification_usecase.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! features
  // blocs
  getIt.registerFactory(
    () => ApplicationBloc(
      getAllApps: getIt(),
      createApp: getIt(),
      deleteApp: getIt(),
      getApp: getIt(),
      updateApp: getIt(),
    ),
  );

  getIt.registerFactory(
    () => NotificationBloc(
      createNotification: getIt(),
      updateNotification: getIt(),
      getAppsNotifications: getIt(),
      getNotification: getIt(),
      deleteNotification: getIt(),
      deleteAppNotifications: getIt(),
      sendNotification: getIt(),
    ),
  );

  // usecases
  getIt.registerLazySingleton(() => GetAllAppsUsecase(getIt()));
  getIt.registerLazySingleton(() => GetAppUsecase(getIt()));
  getIt.registerLazySingleton(() => CreateAppUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAppUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateAppUsecase(getIt()));

  getIt.registerLazySingleton(() => GetAppNotificationsUsecase(getIt()));
  getIt.registerLazySingleton(() => GetNotificationUsecase(getIt()));
  getIt.registerLazySingleton(() => CreateNotificationUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateNotificationUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteNotificationUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAppNotificationsUsecase(getIt()));
  getIt.registerLazySingleton(() => SendNotificationUsecase(getIt()));

  // repositories
  getIt.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(datasource: getIt()),
  );
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      notificationLocalData: getIt(),
      notificationRemoteData: getIt(),
    ),
  );

  //! data
  // data sources
  getIt.registerLazySingleton<AppLocalDatasource>(
    () => AppLocalDatasourceImpl(
      appBox: getIt(),
    ),
  );
  getIt.registerLazySingleton<NotificationLocalDatasource>(
    () => NotificationLocalDatasourceImpl(
      notificationBox: getIt(),
    ),
  );
  getIt.registerLazySingleton<NotificationRemoteDatasource>(
    () => NotificationRemoteDatasourceImpl(
      dioClient: getIt(),
    ),
  );

  //! external
  // hive
  Hive.registerAdapter(AppModelAdapter());
  Hive.registerAdapter(NotificationModelAdapter());
  Hive.registerAdapter(NotificationReceiverTypeAdapter());
  Hive.registerAdapter(NotificationTypeAdapter());
  Hive.registerAdapter(FcmApiTypeAdapter());
  Hive.registerAdapter(DataModelAdapter());
  // app box
  var appBox = await Hive.openBox<AppModel>(Strings.appBox);
  getIt.registerLazySingleton(() => appBox);

  // notification box
  var notificationBox =
      await Hive.openBox<NotificationModel>(Strings.notificationBox);
  getIt.registerLazySingleton(() => notificationBox);

  // SweetSheet - bottom sheet
  getIt.registerSingleton(SweetSheet());

  // dio client
  getIt.registerLazySingleton(() => DioClient());
}
