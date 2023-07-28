import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = ChangeNotifierProvider((ref) => ThemeModeNotifier());

class ThemeModeNotifier extends ChangeNotifier {
  //todo fetch Mode from cache
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _themeMode = value;
    //todo cache theme mode to shared preferences
    notifyListeners();
  }
}
