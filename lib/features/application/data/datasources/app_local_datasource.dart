import 'package:hive/hive.dart';

import 'package:fcm_notification/features/application/data/models/app_model.dart';

abstract class AppLocalDatasource {
  Future<List<AppModel>> getAllApps();
  Future<AppModel> getApp({required String id});
  Future<void> createApp({required AppModel app});
  Future<void> updateApp({required AppModel app});
  Future<void> deleteApp({required String id});
}

class AppLocalDatasourceImpl implements AppLocalDatasource {
  final Box<AppModel> appBox;
  AppLocalDatasourceImpl({
    required this.appBox,
  });

  @override
  Future<void> createApp({required AppModel app}) async {
    return await appBox.put(app.id, app);
  }

  @override
  Future<void> deleteApp({required String id}) async {
    return await appBox.delete(id);
  }

  @override
  Future<List<AppModel>> getAllApps() async {
    return appBox.values.toList();
  }

  @override
  Future<AppModel> getApp({required String id}) async {
    return await Future.value(appBox.get(id));
  }

  @override
  Future<void> updateApp({required AppModel app}) async {
    return await appBox.put(app.id, app);
  }
}
