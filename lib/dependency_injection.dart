import 'package:fcm_notification/core/constants/strings.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'features/application/data/models/app_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! features
  // blocs
  // usecases
  // repositories
  //! core
  //! data
  // data sources
  //! external

  // hive
  Hive.registerAdapter(AppModelAdapter());
  var appBox = await Hive.openBox<AppEntity>(Strings.appBox);
  getIt.registerLazySingleton(() => appBox);
}
