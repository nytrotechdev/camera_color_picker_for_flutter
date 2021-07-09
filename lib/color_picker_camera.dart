import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ColorPickerCamera {
  static const MethodChannel _channel =
      const MethodChannel('color_picker_camera');

  static Future<String> get captureColorFromCamera async {
    try {
      if (await Permission.camera.request().isGranted) {
        var result = await _channel.invokeMethod('startNewActivity');
        return result;
      } else {
        print("Permission not granted");
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
