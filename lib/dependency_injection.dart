import 'package:fcm_notification/core/constants/strings.dart';
import 'package:fcm_notification/features/application/data/repositories/app_repository_impl.dart';
import 'package:fcm_notification/features/application/domain/repositories/app_repository.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'features/application/data/datasources/app_local_datasource.dart';
import 'features/application/data/models/app_model.dart';
import 'features/application/domain/usecases/get_all_apps_usecase.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! features
  // blocs
  getIt.registerFactory(
    () => ApplicationBloc(
      getAllApps: getIt(),
    ),
  );

  // usecases
  getIt.registerLazySingleton(() => GetAllAppsUsecase(getIt()));

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
  Hive.registerAdapter(AppModelAdapter());
  await Hive.openBox<AppModel>(Strings.appBox);

  var appBox = Hive.box<AppModel>(Strings.appBox);
  getIt.registerLazySingleton(() => appBox);
}
