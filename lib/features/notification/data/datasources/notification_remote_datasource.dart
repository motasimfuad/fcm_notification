import 'package:dio/dio.dart';
import 'package:fcm_notification/core/constants/constants.dart';
import 'package:fcm_notification/core/services/dio_client.dart';

import '../models/notification_model.dart';

abstract class NotificationRemoteDatasource {
  Future<Response> sendNotification(
      {required String serverKey, required NotificationModel notification});
}

class NotificationRemoteDatasourceImpl implements NotificationRemoteDatasource {
  final DioClient dioClient;
  NotificationRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<Response> sendNotification({
    required String serverKey,
    required NotificationModel notification,
  }) async {
    //* Send notification to All users with topic
    if (notification.receiverType == NotificationReceiverType.all) {
      var response = await sendNotificationToAll(serverKey, notification);
      return response;
    } else {
      //* Send notification to a single user with registration id
      var response =
          await sendNotificationToSingleUser(serverKey, notification);
      return response;
    }
  }

  Future<dynamic> sendNotificationToAll(
    String serverKey,
    NotificationModel notification,
  ) async {
    return await dioClient.postRequest(
      serverKey: serverKey,
      data: {
        'to': '/topics/${notification.topicName}',
        "priority": "high",
        'notification': {
          'title': notification.title,
          'body': notification.body,
          'image': notification.imageUrl,
          'sound': 'default',
          'data': {
            '${notification.dataKey}': '${notification.dataValue}',
          },
        },
      },
    );
  }

  Future<dynamic> sendNotificationToSingleUser(
    String serverKey,
    NotificationModel notification,
  ) async {
    return await dioClient.postRequest(
      serverKey: serverKey,
      data: {
        'registration_ids': ['${notification.deviceId}'],
        'priority': 'high',
        'notification': {
          'title': notification.title,
          'body': notification.body,
          'image': notification.imageUrl,
          'sound': 'default',
          'data': {
            '${notification.dataKey}': '${notification.dataValue}',
          },
        },
      },
    );
  }
}
