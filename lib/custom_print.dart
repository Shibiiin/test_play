import 'package:flutter/foundation.dart';

void customPrint(String message) {
  if (!kReleaseMode) {
    debugPrint(message);
  }
}
