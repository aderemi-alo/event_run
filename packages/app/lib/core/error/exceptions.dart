class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;
  const CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class AppAuthException implements Exception {
  final String message;
  const AppAuthException({required this.message});

  @override
  String toString() => 'AuthException: $message';
}
