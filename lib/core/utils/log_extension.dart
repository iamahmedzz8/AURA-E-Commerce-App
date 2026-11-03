// log_extension.dart
import 'dart:developer';

import 'package:flutter/foundation.dart';

extension LogExtension on Object {
  void logger(String name, {String? message}) {
    if (kDebugMode) {
      log(message ?? toString(), name: name);
    }
  }
}
