import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyConsoleOutput extends LogOutput {
  MyConsoleOutput({this.packageName});

  final String packageName;

  @override
  void output(OutputEvent event) {
    event.lines.forEach((value) {
      if (packageName != null) {
        debugPrint('${DateTime.now()}: $packageName: ' + value);
      } else {
        debugPrint('${DateTime.now()}: ' + value);
      }
    });
  }
}
