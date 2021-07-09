import 'dart:io';

import 'package:flutter/material.dart';

import 'package:color_picker_camera/color_picker_camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Color bgColor;
  String selectedColor = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Color Picker Camera"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello fellows :)"),
              SizedBox(
                height: 10,
              ),
              Text(selectedColor),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: Colors.red,
                onPressed: () async {
                  String colorCode =
                      await ColorPickerCamera.captureColorFromCamera;
                  setState(() {
                    selectedColor = colorCode;
                    bgColor = Color(int.parse(colorCode));
                  });
                },
                child: Text("Go To Camera"),
              )
            ],
          ),
        ));
  }
}
