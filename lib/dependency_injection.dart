import 'package:fcm_notification/core/constants/strings.dart';
import 'package:fcm_notification/features/application/data/repositories/app_repository_impl.dart';
import 'package:fcm_notification/features/application/domain/repositories/app_repository.dart';
import 'package:fcm_notification/features/application/domain/usecases/create_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/delete_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/get_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/update_app_usecase.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'features/application/data/datasources/app_local_datasource.dart';
import 'features/application/data/models/app_model.dart';
import 'features/application/domain/usecases/get_all_apps_usecase.dart';
import 'features/notification/data/models/notification_model.dart';

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

  // usecases
  getIt.registerLazySingleton(() => GetAllAppsUsecase(getIt()));
  getIt.registerLazySingleton(() => GetAppUsecase(getIt()));
  getIt.registerLazySingleton(() => CreateAppUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAppUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateAppUsecase(getIt()));

  // repositories
  getIt.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(datasource: getIt()),
  );

  //! core
  //! data
  // data sources
  getIt.registerLazySingleton<AppLocalDatasource>(
    () => AppLocalDatasourceImpl(
      appBox: getIt(),
    ),
  );

  //! external

  // hive
  // app box
  Hive.registerAdapter(AppModelAdapter());
  var appBox = await Hive.openBox<AppModel>(Strings.appBox);
  getIt.registerLazySingleton(() => appBox);

  // notification box
  Hive.registerAdapter(NotificationModelAdapter());
  var notificationBox =
      await Hive.openBox<NotificationModel>(Strings.notificationBox);
  getIt.registerLazySingleton(() => notificationBox);
}
