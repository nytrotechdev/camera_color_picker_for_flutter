import 'package:flutter/material.dart';

Widget GradientContainer(Widget MyWidget) {
  return Container(
    decoration: new BoxDecoration(
      gradient: new LinearGradient(
          colors: [
            const Color(0xFF0F2027),
            const Color(0xFF2C5364),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    ),
    child: MyWidget,
  );
}

Widget ButtonContainer(Widget MyWidget, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: new LinearGradient(
          colors: [
            const Color(0xFF0F2027),
            const Color(0xFF2C5364),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    ),
    child: MyWidget,
  );
}
