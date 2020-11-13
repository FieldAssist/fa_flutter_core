import 'package:flutter/material.dart';

@immutable
class MyException implements Exception {
  const MyException(this.message);

  final String message;

  @override
  String toString() {
    return message ?? 'NA';
  }
}
