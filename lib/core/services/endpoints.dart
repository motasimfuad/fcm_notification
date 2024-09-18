class Endpoints {
  static const String legacyApi = 'https://fcm.googleapis.com/fcm/send';

  static String v1Api(String projectId) =>
      'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';
}
