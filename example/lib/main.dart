import 'package:color_picker_camera_example/model/DatabaseHelper.dart';
import 'package:color_picker_camera_example/utils/gradientContainer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:color_picker_camera/color_picker_camera.dart';

// dartvoid main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String _platformVersion = 'Unknown';
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = await ColorPickerCamera.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Text('Running on: $_platformVersion\n'),
//         ),
//       ),
//     );
//   }
// }

import 'model/ColorPallete.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _bgColor;
  String text;
  ColorPickerCamera myPrivatePlugin = new ColorPickerCamera();
  @override
  void initState() {
    myPrivatePlugin.listen();
    _query(context);
    super.initState();
  }

  String imgPath = "";
  TextEditingController _textFieldController = new TextEditingController();

  String path = "/storage/emulated/0/Phone/Download/10_recipes.png";
  String colorName = "";
  Future<void> _saveColorName(BuildContext context, String colorCode,
      String imagePath, String name) async {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child:
                AlertDialog(content: ColorSaveName(colorCode, imagePath, name)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          // centerTitle: true,
          // title: Text("Color Picker", style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF0F2027),
          pinned: true,
          // backgroundColor: primaryColor,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Container(child: GradientContainer(Container())),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.color_lens_rounded,
                  color: Color(0xFFe3e9e9),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Color Picker",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFe3e9e9),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            // crossAxisCount: 2,

            maxCrossAxisExtent: 200,
            mainAxisSpacing: 10, //mid horizontal spacing
            crossAxisSpacing: 0, //mid spacing spacing
            childAspectRatio: 1.2, //full screen
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Stack(children: [
                Card(
                  color: Colors.white,
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            _saveColorName(
                                context,
                                colorPalete[index].colorCode,
                                colorPalete[index].imagePath,
                                colorPalete[index].name);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit,
                                  size: 12, color: Colors.deepOrange),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${colorPalete[index].name.toUpperCase()}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Color(int.parse(colorPalete[index].colorCode)),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey[300],
                                offset: new Offset(10.0, 10.0),
                              ),
                            ],
                          ),
                          height: 60,
                          width: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hex: ${colorPalete[index].colorCode.replaceAll("0xff", "#")}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    right: 20,
                    bottom: 0,
                    child: InkWell(
                        onTap: () {
                          deleteColorPalete(colorPalete[index].colorCode);
                          _query(context);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color: Color(0xFF2C5364),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.delete,
                                    size: 16, color: Colors.red),
                              ),
                            ))))
              ]);
            },
            childCount: colorPalete.length,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ColorPickerCamera.generateColor().then((value) {
            if (value != "") {
              print(value);
              setState(() {
                text = value;
                String imageFrom;
                String hexColor;
                if (text.indexOf("#") != -1) {
                  hexColor = text.replaceAll('#', '0xff');

                  imageFrom = "Android Camera Set";
                } else {
                  hexColor = "0xff$text";

                  imageFrom = "IOS Camera Set";
                }
                _saveColorName(context, hexColor, imageFrom, "");
              });
            }
          });
        },
        child: Icon(Icons.add_circle_outline, color: Colors.white),
        backgroundColor: Color(0xFF2C5364),
      ),
    );
  }

  List<ColorPallete> colorPalete = [];

  _query(BuildContext context) async {
    final dbHelper = DatabaseHelper.instance;
    // dbHelper.removeItems();
    ColorPallete myPallete = new ColorPallete();
    List<ColorPallete> listOfColors = [];
    dbHelper.queryAllRows().then((allRows) {
      print("---------------------$allRows--------------");
      if (allRows.isNotEmpty) {
        for (int i = 0; i < allRows.length; i++) {
          ColorPallete myPallete = new ColorPallete();
          myPallete.name = allRows[i]['color_name'];
          myPallete.imagePath = allRows[i]['image'];
          myPallete.colorCode = allRows[i]['color_code'];
          listOfColors.add(myPallete);
        }
        setState(() {
          colorPalete = listOfColors;
        });
      }
    });
  }

  Widget ColorSaveName(String colorCode, String imagePath, String name) {
    TextEditingController _textFieldController =
        new TextEditingController(text: name);
    String colorName = _textFieldController.text;
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                colorCode.replaceAll("0xff", "#"),
                style: TextStyle(color: Colors.black),
              ),
              TextFormField(
                maxLength: 16,
                decoration: InputDecoration(
                  labelText: 'Enter Color Name',
                  labelStyle: TextStyle(color: Color(0xFF2C5364)),
                  // enabledBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.red),
                  // ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2C5364)),
                  ),
                ),
                cursorColor: Color(0xFF2C5364),
                onChanged: (value) {
                  setState(() {
                    colorName = value;
                    print(value);
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Give name to the color";
                  }
                  return null;
                },
                controller: _textFieldController,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    ColorPallete colorPallete = ColorPallete();
                    colorPallete.colorCode = colorCode;
                    colorPallete.imagePath = imagePath;
                    colorPallete.name = colorName;
                    if (name != "") {
                      updateColorPalete(colorPallete).then((value) {
                        _query(context);
                      });
                    } else {
                      addColorToPalete(colorPallete).then((value) {
                        _query(context);
                      });
                    }
                    Navigator.pop(context);
                  }
                },
                child: ButtonContainer(
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> addColorToPalete(ColorPallete colorPallete) async {
    final dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: colorPallete.name,
      DatabaseHelper.columnColorCode: colorPallete.colorCode,
      DatabaseHelper.columnImage: colorPallete.imagePath,
    };
    final id = await dbHelper.insert(row);
    return "inserted";
  }

  Future<String> updateColorPalete(ColorPallete colorPallete) async {
    final dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: colorPallete.name,
      DatabaseHelper.columnColorCode: colorPallete.colorCode,
      DatabaseHelper.columnImage: colorPallete.imagePath,
    };
    final id = await dbHelper.update(row);
    return "updated";
  }

  Future<String> deleteColorPalete(String code) async {
    final dbHelper = DatabaseHelper.instance;

    final id = await dbHelper.delete(code);
    return "deleted";
  }
}
