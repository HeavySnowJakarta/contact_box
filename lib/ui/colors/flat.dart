// The color schemes here is inspired by Flat UI Palette v1.
// This file provides a function to generate a ColorScheme based on the
// color provided. An enum is used to describe the colors.

import 'package:flutter/material.dart';
import './color.dart';

// Totally 10 colors are provided, all of which has light and dark versions.
// The actual colors:
const int _LIGHT_CYAN = 0xff1abc9c;   // TURQUOISE
const int _LIGHT_GREEN = 0xff2ecc71;  // EMERALD
const int _LIGHT_BLUE = 0xff3498db;   // PETER RIVER
const int _LIGHT_PURPLE = 0xff3498db; // AMETHYST
const int _LIGHT_BLACK = 0xff34495e;  // WET ASPHALT
const int _LIGHT_YELLOW = 0xfff1c40f; // SUNFLOWER
const int _LIGHT_ORANGE = 0xffe67e22; // CARROT
const int _LIGHT_RED = 0xffe74c3c;    // ALIZARIN
const int _LIGHT_WHITE = 0xffecf0f1;  // CLOUDS
const int _LIGHT_BROWN = 0xff95a5a6;  // CONCRETE

const int _DARK_CYAN = 0xff16a085;    // GREEN SEA
const int _DARK_GREEN = 0xff27ae60;   // NEPHRITIS
const int _DARK_BLUE = 0xff2980b9;    // BELIZE HOLE
const int _DARK_PURPLE = 0xff8e44ad;  // WISTERIA
const int _DARK_BLACK = 0xff2c3e50;   // MIDNIGHT BLUE
const int _DARK_YELLOW = 0xfff39c12;  // ORANGE
const int _DARK_ORANGE = 0xffd35400;  // PUMPKIN
const int _DARK_RED = 0xffc0392b;     // POMEGRANATE
const int _DARK_WHITE = 0xffbdc3c7;   // SILVER
const int _DARK_BROWN = 0xff7f8c8d;   // ASBESTOS

class FlatColor extends ColorSetScheme{
  FlatColor();

  @override
  int getColorValue(ColorSet color, bool dark){
    switch (dark){
      case true:
        return switch (color){
          ColorSet.cyan =>
            _DARK_CYAN,
          ColorSet.green =>
            _DARK_GREEN,
          ColorSet.blue =>
            _DARK_BLUE,
          ColorSet.purple =>
            _DARK_PURPLE,
          ColorSet.black =>
            _DARK_BLACK,
          ColorSet.yellow =>
            _DARK_YELLOW,
          ColorSet.orange =>
            _DARK_YELLOW,
          ColorSet.red =>
            _DARK_RED,
          ColorSet.white =>
            _DARK_WHITE,
          ColorSet.brown =>
            _DARK_BROWN
        };
      case false:
        return switch (color){
          ColorSet.cyan =>
            _LIGHT_CYAN,
          ColorSet.green =>
            _LIGHT_GREEN,
          ColorSet.blue =>
            _LIGHT_BLUE,
          ColorSet.purple =>
            _LIGHT_PURPLE,
          ColorSet.black =>
            _LIGHT_BLACK,
          ColorSet.yellow =>
            _LIGHT_YELLOW,
          ColorSet.orange =>
            _LIGHT_YELLOW,
          ColorSet.red =>
            _LIGHT_RED,
          ColorSet.white =>
            _LIGHT_WHITE,
          ColorSet.brown =>
            _LIGHT_BROWN
        };
    }
  }

  @override
  ColorScheme getColorScheme(ColorSet color, bool dark){
    final Color seedColor = Color(getColorValue(color, dark));
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: dark ? Brightness.dark : Brightness.light
    );
  }
}

/*

// Generate the color scheme based on the given seed color and whether it
// should be dark.
// `color`: The seed color from `enum FlatColor`.
// `dark`: be true for dark mode and false for light mode.
ColorScheme getColorScheme(ColorSet color, bool dark){
  switch (dark){
    case true:
      var seed = switch (color){
        ColorSet.cyan =>
          _DARK_CYAN,
        ColorSet.green =>
          _DARK_GREEN,
        ColorSet.blue =>
          _DARK_BLUE,
        ColorSet.purple =>
          _DARK_PURPLE,
        ColorSet.black =>
          _DARK_BLACK,
        ColorSet.yellow =>
          _DARK_YELLOW,
        ColorSet.orange =>
          _DARK_YELLOW,
        ColorSet.red =>
          _DARK_RED,
        ColorSet.white =>
          _DARK_WHITE,
        ColorSet.brown =>
          _DARK_BROWN
      };
      Color seedColor = Color(seed);
      final ans = ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark
      );
      return ans;
    case false:
      var seed = switch (color){
        ColorSet.cyan =>
          _LIGHT_CYAN,
        ColorSet.green =>
          _LIGHT_GREEN,
        ColorSet.blue =>
          _LIGHT_BLUE,
        ColorSet.purple =>
          _LIGHT_PURPLE,
        ColorSet.black =>
          _LIGHT_BLACK,
        ColorSet.yellow =>
          _LIGHT_YELLOW,
        ColorSet.orange =>
          _LIGHT_YELLOW,
        ColorSet.red =>
          _LIGHT_RED,
        ColorSet.white =>
          _LIGHT_WHITE,
        ColorSet.brown =>
          _LIGHT_BROWN
      };
      Color seedColor = Color(seed);
      final ans = ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light
      );
      return ans;
  }
}

*/