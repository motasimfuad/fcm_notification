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
    //* Send notification
    if (notification.notificationType == NotificationType.notification) {
      //* Send notification to All with topic
      if (notification.receiverType == NotificationReceiverType.all) {
        var response = await sendNotificationToAll(serverKey, notification);
        return response;
      } else {
        //* Send notification to a single user with topic
        var response =
            await sendNotificationToSingleUser(serverKey, notification);
        return response;
      }

      //* Send data-message
    } else if (notification.notificationType == NotificationType.dataMessage) {
      //* Send data-message to All with topic
      if (notification.receiverType == NotificationReceiverType.all) {
        var response = await sendDataMessageToAll(serverKey, notification);
        return response;
      } else {
        //* Send data-message to a single user with topic
        var response =
            await sendDataMessageToSingleUser(serverKey, notification);
        return response;
      }
    } else {
      var response = await sendNotificationToAll(serverKey, notification);
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
          "sound": "default",
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
          "sound": "default",
        },
      },
    );
  }

  Future<dynamic> sendDataMessageToAll(
    String serverKey,
    NotificationModel notification,
  ) async {
    return await dioClient.postRequest(
      serverKey: serverKey,
      data: {
        'to': '/topics/${notification.topicName}',
        'data': {
          '${notification.dataKey}': '${notification.dataValue}',
        },
      },
    );
  }

  Future<dynamic> sendDataMessageToSingleUser(
    String serverKey,
    NotificationModel notification,
  ) async {
    return await dioClient.postRequest(
      serverKey: serverKey,
      data: {
        'registration_ids': ['${notification.deviceId}'],
        'data': {
          '${notification.dataKey}': '${notification.dataValue}',
        },
      },
    );
  }
}
