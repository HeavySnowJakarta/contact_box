# Color related things

This directory defines color related data.

- `color.dart`: an enum `ColorSet`, which defines some most used colors that maybe decided by a color set scheme, and an abstract class `ColorSetScheme` that's refered by the specific color schemes.
- `color_setting.dart`: Read the configuration from the settings.
- `flat.dart`: A series of color schemes like Flat UI.
- Other schemes you may want to add, each one as a `.dart` file.

### Why Flat?
It may be better to provided different color schemes to let the user choose,
but for now it's more convenient to focus on the app functions rather than
the apperance, so I chose Flat we you won't need to spend too much time to
decide how it should look like. But it's extendable and you can add the scheme as you want at the level of source code.

### Why not `Colors.blue` or somethings else?
For the possible extendability, I use `Color(colorScheme.getColor(ColorSet.blue, false))` instead.

### Add your own scheme
This part is not the most important of this app, but it maybe useful for who may concern.

#### What a color set scheme is expected to include
You're suggested to add every scheme you want as a independent file, and name it just like `flat.dart`. Then, you'd better refer to `color.dart` first to see what your _own_ color set scheme is expected to include:

```dart
// A color scheme should has a set of integers, each standing for a specific
// color of the `enum ColorSet` above.
abstract class ColorSetScheme{
  // Get the color value based on the color required.
  // `color`: The color required.
  // `dark`: be true for dark mode and false for light mode.
  int getColor(ColorSet color, bool dark);

  // Generate the color scheme based on the given seed color and whether it
  // should be dark.
  // `color`: The seed color from `enum FlatColor`.
  // `dark`: be true for dark mode and false for light mode.
  ColorScheme getColorScheme(ColorSet color, bool dark);
}
```

That's to say, you have to define a class that extends `ColorSetScheme`, which includes methods of `getColor()` and `getColorScheme()`. The project can use the two methods to decide which color exactly to use depends on the color set scheme's configuration. Sometimes just follow `flat.dart` is just okay.

#### Configurate on `color.dart`
This step is not hard at all. Your class may has a constructor just like

```dart
class FlatColor extends ColorSetScheme{
  FlatColor();
}
```

and you may have already found on `color.dart`

```dart
ColorSetScheme colorSetScheme = FlatColor();
```

That's it. just import your Dart file on `color.dart` and replace `FlatColor()` to your constructor, and if it works as `flat.dart`, the other parts of the project will just follow the rule.

### About hot update of color set schemes
It's actual possible to let the user choose their favored color set scheme, but it's NOT THE MOST IMPORTANT PART of this project. If it's really needed it's also quite easy to add the function.