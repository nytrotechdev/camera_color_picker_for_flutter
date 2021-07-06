class ColorPallete {
  int _id;
  String _colorCode;
  String _name;
  String _imagePath;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get colorCode => _colorCode;

  String get imagePath => _imagePath;

  set imagePath(String value) {
    _imagePath = value;
  }

  set colorCode(String value) {
    _colorCode = value;
  }
}
