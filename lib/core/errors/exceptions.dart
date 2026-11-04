/// Base and specific exceptions used across data sources and network operations.

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({this.message = 'Server Exception', this.statusCode});

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Cache Exception'});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'Network Exception'});

  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;

  AuthException({this.message = 'Auth Exception'});

  @override
  String toString() => 'AuthException: $message';
}

class NoDataException implements Exception {}

class ConnectionException implements Exception {}

