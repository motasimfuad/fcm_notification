import 'package:fcm_notification/features/application/data/models/app_model.dart';

abstract class AppLocalDatasource {
  Future<List<AppModel>> getAllApps();
}
