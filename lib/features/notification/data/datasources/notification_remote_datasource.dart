import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fcm_notification/core/constants/constants.dart';
import 'package:fcm_notification/core/services/dio_client.dart';
import 'package:fcm_notification/core/services/endpoints.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

import '../models/notification_model.dart';

abstract class NotificationRemoteDatasource {
  Future<Response> sendNotification({
    required String serverKey,
    required NotificationModel notification,
  });
}

class NotificationRemoteDatasourceImpl implements NotificationRemoteDatasource {
  final DioClient dioClient;
  NotificationRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<Response> sendNotification({
    required String serverKey,
    required NotificationModel notification,
  }) async {
    if (serverKey.isJson) {
      final serviceJson = jsonDecode(serverKey);
      final accessToken = await _getServerAccessToken(serviceJson);
      final appId = serviceJson['project_id'];

      return await _sendV1Notification(
        appId: appId,
        accessToken: accessToken,
        notification: notification,
      );
    } else {
      return await _handleLegacyNotifications(
        serverKey: serverKey,
        notification: notification,
      );
    }
  }

  Future<dynamic> _sendV1Notification({
    required String appId,
    required String accessToken,
    required NotificationModel notification,
  }) async {
    return await dioClient.post(
      Endpoints.v1Api(appId),
      {
        "message": {
          if (notification.receiverType == NotificationReceiverType.all)
            "topic": notification.topicName,
          if (notification.receiverType == NotificationReceiverType.single)
            "token": notification.deviceId,
          "notification": {
            'title': notification.title,
            'body': notification.body,
            'image': notification.imageUrl,
          },
          "android": {
            "priority": "high",
            "notification": {
              'sound': 'default',
            }
          },
          'data': notification.data?.asMap().map(
                (key, value) => MapEntry(
                  value.keyData,
                  value.valueData,
                ),
              ),
        }
      },
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }

  Future<String> _getServerAccessToken(
    Map<String, dynamic> serviceJson,
  ) async {
    final client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceJson),
      _scopes,
    );
    final accessToken = client.credentials.accessToken.data;

    return accessToken;
  }

  Future<Response> _handleLegacyNotifications({
    required String serverKey,
    required NotificationModel notification,
  }) async {
    //* Send notification to All users with topic
    if (notification.receiverType == NotificationReceiverType.all) {
      var response =
          await _sendLegacyNotificationToAll(serverKey, notification);
      return response;
    } else {
      //* Send notification to a single user with registration id
      var response =
          await _sendLegacyNotificationToSingleUser(serverKey, notification);
      return response;
    }
  }

  Future<dynamic> _sendLegacyNotificationToAll(
    String serverKey,
    NotificationModel notification,
  ) async {
    return await dioClient.post(
      Endpoints.legacyApi,
      {
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
      headers: {'Authorization': 'key=$serverKey'},
    );
  }

  Future<dynamic> _sendLegacyNotificationToSingleUser(
    String serverKey,
    NotificationModel notification,
  ) async {
    return await dioClient.post(
      Endpoints.legacyApi,
      {
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
      headers: {'Authorization': 'key=$serverKey'},
    );
  }
}

List<String> _scopes = [
  "https://www.googleapis.com/auth/firebase.messaging",
];
