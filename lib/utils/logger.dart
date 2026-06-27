import 'dart:developer' as developer;

enum LogLevel { debug, info, warning, error }

class AppLogger {
  AppLogger._();

  static LogLevel _minLevel = LogLevel.debug;

  static void setLevel(LogLevel level) {
    _minLevel = level;
  }

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, error, stackTrace);
  }

  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, error, stackTrace);
  }

  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, message, error, stackTrace);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  static void _log(
    LogLevel level,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (level.index < _minLevel.index) return;
    final prefix = '[${level.name.toUpperCase()}]';
    final logMsg = '$prefix $message';
    developer.log(logMsg, name: 'AppLogger', error: error, stackTrace: stackTrace);
  }
}