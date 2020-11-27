import 'package:logger/logger.dart';

import 'base/app_log.dart';
import 'logger/output/my_console_output.dart';
import 'logger/printer/my_pretty_printer.dart';

class AppLogImpl implements AppLog {
  final _logger = Logger(
    printer: MyPrettyPrinter(),
    output: MyConsoleOutput(),
  );

  @override
  void d(object) {
    _logger.d(object);
  }

  @override
  void e(object, StackTrace s) {
    _logger.e(object, null, s);
  }

  @override
  void i(object) {
    _logger.i(object);
  }

  @override
  void v(object) {
    _logger.v(object);
  }

  @override
  void w(object) {
    _logger.w(object);
  }

  @override
  void wtf(object) {
    _logger.wtf(object);
  }
}
