import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  var backgroundColor = Colors.white;
  var textColor = Colors.black;
  var buttonColor = const Color.fromARGB(255, 21, 107, 194);
  var imageDark = "assets/mimo.png";
  bool isThemeChanged = true;
  var buttonTextColor = Colors.white;
  var addButtonColor = Colors.black45;
  void changeTheme() {
    isThemeChanged = !isThemeChanged;
    backgroundColor =
        isThemeChanged ? Colors.white : const Color.fromARGB(255, 24, 24, 24);
    textColor = isThemeChanged ? Colors.black : Colors.white;
    buttonColor = isThemeChanged
        ? const Color.fromARGB(255, 21, 107, 194)
        : const Color.fromARGB(255, 21, 107, 194);
    imageDark = isThemeChanged ? "assets/mimo.png" : "assets/image.png";
    addButtonColor = isThemeChanged ? Colors.black45 : Colors.white;
    notifyListeners();
  }
}
