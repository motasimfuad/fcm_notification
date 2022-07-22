import 'package:fcm_notification/core/services/dio_client.dart';

abstract class AppRemoteDatasource {}

class AppRemoteDatasourceImpl implements AppRemoteDatasource {
  final DioClient dioClient;
  AppRemoteDatasourceImpl(this.dioClient);

  Future sendNotification() {
    return dioClient.postRequest(
      serverKey: '',
      data: {
        'to': 'fcm_token',
        'notification': {
          'title': 'FCM Notification',
          'body': 'FCM Notification Body',
        },
        'data': {
          'title': 'FCM Notification',
          'body': 'FCM Notification Body',
        },
      },
    );
  }
}
