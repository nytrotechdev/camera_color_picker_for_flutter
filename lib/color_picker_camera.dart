import 'dart:async';

import 'package:flutter/services.dart';

class ColorPickerCamera {
  static const MethodChannel _channel =
      const MethodChannel('color_picker_camera');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> captureColorFromCamera() async {
    try {
      var result = await _channel.invokeMethod('startNewActivity');
      return result;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
