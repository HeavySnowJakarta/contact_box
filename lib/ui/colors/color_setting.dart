// Reads and sets which theme to use from and to the setting with
// `shared_preferences`.

import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import './color.dart';

// See if the system uses dark mode.
// About the value to return:
// `true`: Dark mode.
// `false`: Light mode.
bool _judgeDarkMode(){
  WidgetsFlutterBinding.ensureInitialized();
  final brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
  return (brightness == Brightness.dark);
}

// Set the default color value and return the corresponding color.
Future<ColorSet> setDefaultSeedColor(SharedPreferences prefs) async{
  await prefs.setInt('seedColor', 2);
  return ColorSet.blue;
}

// Set the default value of dark mode and return the corresponding bool value.
Future<bool> setDefaultDarkMode(SharedPreferences prefs) async{
  await prefs.setInt('darkMode', 0);
  return _judgeDarkMode();
}

// Read the scheme-related settings from `shared_preferences`. If the
// setting does not exist or make sence, set and use the default ones.
// This function gets two settings: `seedColor` and `darkModeSetting`.
// `seedColor` is a number from a list, each of whom corresponds to a color
// from `enum FlatColor` from ./flat.dart.
// See `enum FlatColor` from ./flat.dart for details.
// `darkModeSetting` has three different possible values:
// 0: Follow the system. (default)
// 1: Light only.
// 2: Dark only.
Future<ColorScheme> readFromSettings() async{
  // Read the settings.
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int? seedColorInt = prefs.getInt('seedColor');
  int? darkModeSetting = prefs.getInt('darkMode');

  // See if the settings exist and make sence.
  ColorSet seedColor = switch (seedColorInt){
    0 => ColorSet.cyan,
    1 => ColorSet.green,
    2 => ColorSet.blue,
    3 => ColorSet.purple,
    4 => ColorSet.black,
    5 => ColorSet.yellow,
    6 => ColorSet.orange,
    7 => ColorSet.red,
    8 => ColorSet.white,
    9 => ColorSet.brown,
    null || _=> await setDefaultSeedColor(prefs)
  };
  bool useDarkMode = switch (darkModeSetting){
    0 => _judgeDarkMode(),
    1 => true,
    2 => false,
    null || _ => await setDefaultDarkMode(prefs)
  };

  // Return the real color scheme.
  return colorSetScheme.getColorScheme(seedColor, useDarkMode);
}

Future<void> setSeedColorToSettings(ColorSet color) async{
  int colorValue = switch (color){
    ColorSet.cyan => 0,
    ColorSet.green => 1,
    ColorSet.blue => 2,
    ColorSet.purple => 3,
    ColorSet.black => 4,
    ColorSet.yellow => 5,
    ColorSet.orange => 6,
    ColorSet.red => 7,
    ColorSet.white => 8,
    ColorSet.brown => 9
  };

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('seedColor', colorValue);
}

// `darkMode` has three different possible values:
// 0: Follow the system. (default)
// 1: Light only.
// 2: Dark only.
Future<void> setDarkModeToSettings(int darkMode) async{
  if (! (0 <= darkMode && darkMode <= 2)) {
    throw('Non-valid dark mode: $darkMode.');
  }

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('darkMode', darkMode);
}