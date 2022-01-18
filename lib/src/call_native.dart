import 'dart:async';

import 'package:flutter/services.dart';

class SampleCallNativeFlutter {
  static const MethodChannel _channel = const MethodChannel('demo_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> get countNumber async {
    final String? number = await _channel.invokeMethod('getCountNumber');
    return number;
  }

  static void getCountNumber({int? number1, int? number2}) {
    _channel.invokeMethod('getCountNumber', [number1, number2]);
  }

  static void openNativeScreen() {
    _channel.invokeMethod('moveToNaviteScreen');
  }
}
