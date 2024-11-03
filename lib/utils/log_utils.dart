import 'package:flutter/foundation.dart';

class LogUtils {
  static void log(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
