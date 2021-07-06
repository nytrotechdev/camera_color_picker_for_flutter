import 'dart:async';

import 'package:flutter/services.dart';

class ColorPickerCamera {
  static const MethodChannel _channel =
      const MethodChannel('color_picker_camera');
  void listen() {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  Map _callbacksById = new Map();

  Future<void> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'callListener':
        print("call Listner called");
        // _callbacksById[call.arguments["id"]](call.arguments["args"]);
        break;
      default:
        print(
            'TestFairy: Ignoring invoke from native. This normally shouldn\'t happen.');
    }
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> generateColor() async {
    try {
      var result = await _channel.invokeMethod('startNewActivity');
      String response = "";
      print("In flutter");
      print(result);
      return result;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  static Future<String> getNewActivity() async {
    try {
      var result = await _channel.invokeMethod('startNewActivity');
      String response = "";
      print(result);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
