// Generic methods of a color scheme here.
// A color scheme is defined by a set of colors. Here a specific color scheme
// Flat is provided, and you may add your own color schemes (maybe in the
// future).
// This file stores the base class of a ColorSetScheme and `flat.dart` stores
// a specific one.

// You can see a number following each item. As it's easier for
// `shared_preferences` to store integers, the numbers are stored instead.
import 'package:flutter/material.dart';
import './flat.dart';

// When you have already added a new color set scheme file, replace this
// one to the one you want.
ColorSetScheme colorSetScheme = FlatColor();

enum ColorSet{
  cyan,   // 0
  green,  // 1
  blue,   // 2 (default)
  purple, // 3
  black,  // 4
  yellow, // 5
  orange, // 6
  red,    // 7
  white,  // 8
  brown   // 9
}

// A color scheme should has a set of integers, each standing for a specific
// color of the `enum ColorSet` above.
abstract class ColorSetScheme{
  // Get the color value based on the color required.
  // `color`: The color required.
  // `dark`: be true for dark mode and false for light mode.
  int getColorValue(ColorSet color, bool dark);

  // Get the color object based on the color required.
  Color getColor(ColorSet color, bool dark) =>
    Color(getColorValue(color, dark));

  // Generate the color scheme based on the given seed color and whether it
  // should be dark.
  // `color`: The seed color from `enum FlatColor`.
  // `dark`: be true for dark mode and false for light mode.
  ColorScheme getColorScheme(ColorSet color, bool dark);
}