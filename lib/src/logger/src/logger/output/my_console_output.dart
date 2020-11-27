import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach((value) {
      debugPrint(value);
    });
  }
}
