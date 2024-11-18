import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  void showSnack(String? text) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text('${text}')),
    );
  }
}
