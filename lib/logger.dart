import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppLogger {
  final logger = Logger(
    printer: PrettyPrinter(
      printTime: true,
    ),
    filter: ProductionFilter(),
  );

  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.v(message, error, stackTrace);
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error, stackTrace);
  }

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error, stackTrace);
  }

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (message is String) Sentry.captureMessage(message);
    logger.w(message, error, stackTrace);
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    Sentry.captureException(error, stackTrace: stackTrace);
    logger.e(message, error, stackTrace);
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.wtf(message, error, stackTrace);
  }
}

final logger = AppLogger();
