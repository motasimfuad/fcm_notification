class LocalException implements Exception {
  final String? message;
  LocalException({this.message});
}

class RemoteException implements Exception {
  final String? message;
  RemoteException({this.message});
}
