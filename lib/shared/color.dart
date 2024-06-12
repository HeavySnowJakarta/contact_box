// Whether it's on dark mode, and the current foreground and background color.

import 'package:flutter/material.dart';

import 'package:contact_box/ui/colors/color.dart';

class CurrentColors extends InheritedWidget{
  // Whether it's on dark mode.
  bool dark;

  // The forefround and background color.
  late Color fColor;
  late Color bColor;

  CurrentColors._({
    super.key,
    required super.child,
    required this.dark,
    required this.fColor,
    required this.bColor
  });
}