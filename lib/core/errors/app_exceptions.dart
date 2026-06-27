class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const AppException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'AppException: $message (Status: $statusCode)';
}

class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode, super.data});
}

class NetworkException extends AppException {
  const NetworkException({required super.message, super.statusCode});
}

class CacheException extends AppException {
  const CacheException({required super.message});
}

class AuthException extends AppException {
  const AuthException({required super.message, super.statusCode});
}

class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;

  const ValidationException({
    required super.message,
    this.fieldErrors,
    super.statusCode,
  });
}

class LocationException extends AppException {
  const LocationException({required super.message});
}

class PermissionException extends AppException {
  const PermissionException({required super.message});
}
