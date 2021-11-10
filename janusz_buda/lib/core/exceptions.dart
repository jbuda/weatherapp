class AppException implements Exception {
  final String _message;

  AppException(
    this._message,
  );

  @override
  String toString() => _message;
}

class CacheException extends AppException {
  CacheException() : super("Error loading data from cache");
}

class ServerException extends AppException {
  ServerException() : super("Error loading data");
}

class DataException extends AppException {
  DataException() : super("Error parsing data");
}