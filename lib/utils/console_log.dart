import 'package:logger/logger.dart';

class ConsoleLog {
  static Logger _logger = new Logger(
    printer: PrettyPrinter(
        methodCount: 3,
        errorMethodCount: 8,
        lineLength: 120,
        colors: false,
        printEmojis: true,
        printTime: true),
  );

  static i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  static w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  static d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  static e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
}
