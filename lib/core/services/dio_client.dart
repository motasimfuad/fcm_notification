import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  final Map<String, String> _headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  final fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  // Post request
  Future postRequest({required String serverKey, dynamic data}) async {
    _headers['Authorization'] = 'key=$serverKey';
    try {
      final Response response = await _dio.post(
        fcmUrl,
        data: data,
        options: Options(headers: _headers),
      );
      print('this');
      print('response ${response.data}');
    } on DioError catch (e) {
      print('response ${e.message}');
      // throw RemoteException(message: e.message);
      return e.response;
    }
  }
}
