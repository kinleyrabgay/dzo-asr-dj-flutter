import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorModel extends ChangeNotifier {
  late Color _selectedColor;
  SharedPreferences? _prefs;

  ColorModel() {
    _selectedColor = const Color(0xFF0F1F41);
    _initPrefs();
  }

  Color get selectedColor => _selectedColor;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    String? colorCode = _prefs?.getString('color');
    if (colorCode != null) {
      _selectedColor = Color(int.parse(colorCode, radix: 16));
    }
  }

  Future<void> updateColorPreference(Color color) async {
    await _prefs?.setString('color', color.value.toRadixString(16));
    _selectedColor = color;
    notifyListeners();
  }
}
