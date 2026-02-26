import 'package:flutter/material.dart';

/// Theme extension providing a 5-level activity heatmap color scale
/// (index 0 = no activity, 1..4 increasing intensity).
/// Added so widgets like `ActivityGraphWidget` can obtain consistent
/// colors for light & dark mode without hardcoding color values.
class ActivityHeatmapColors extends ThemeExtension<ActivityHeatmapColors> {
  final List<Color> levels; // length 5

  const ActivityHeatmapColors({required this.levels})
      : assert(levels.length == 5);

  // Light mode scale - neutral grey tones
  factory ActivityHeatmapColors.light() => ActivityHeatmapColors(levels: [
        Color(0xFFEEEEEE), // empty - very light grey
        Color(0xFFBDBDBD), // low
        Color(0xFF9E9E9E), // medium
        Color(0xFF757575), // high
        Color(0xFF424242), // very high
      ]);

  // Dark mode scale – grey tones with higher contrast.
  factory ActivityHeatmapColors.dark() => ActivityHeatmapColors(levels: [
        Color(0xFF303030), // empty - dark grey
        Color(0xFF616161), // low
        Color(0xFF757575), // medium
        Color(0xFF9E9E9E), // high
        Color(0xFFBDBDBD), // very high
      ]);

  @override
  ActivityHeatmapColors copyWith({List<Color>? levels}) {
    return ActivityHeatmapColors(levels: levels ?? this.levels);
  }

  @override
  ThemeExtension<ActivityHeatmapColors> lerp(
      covariant ThemeExtension<ActivityHeatmapColors>? other, double t) {
    if (other is! ActivityHeatmapColors) return this;
    return ActivityHeatmapColors(
      levels: List.generate(
          levels.length, (i) => Color.lerp(levels[i], other.levels[i], t)!),
    );
  }
}

ThemeData appThemeLight = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.grey,
  ),
  primaryColor: Colors.grey[800],
  canvasColor: Colors.grey[200],
  secondaryHeaderColor: Colors.grey[600],
  scaffoldBackgroundColor: Colors.grey[100],
  extensions: <ThemeExtension<dynamic>>[
    ActivityHeatmapColors.light(),
  ],
  appBarTheme: AppBarThemeData(
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    titleTextStyle: const TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
    elevation: 1,
    shadowColor: Colors.black12,
  ),
  primaryTextTheme: textThemeLight(),
  textTheme: textThemeLight(),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.grey[800],
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey[800],
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.grey[800]),
    foregroundColor: const WidgetStatePropertyAll(Colors.white),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(fontSize: 16, color: Colors.white),
    ),
  )),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStatePropertyAll(Colors.grey[800]),
    ),
  ),
  cardColor: Colors.white,
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shadowColor: Colors.black12,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.grey[800],
  ),
  iconTheme: IconThemeData(color: Colors.grey[800]),
  primaryIconTheme: IconThemeData(color: Colors.grey[800]),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey[700]!, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
    ),
  ),
  dialogTheme: DialogThemeData(backgroundColor: Colors.white),
);

ThemeData appThemeDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.grey,
      brightness: Brightness.dark,
    ),
    primaryColor: Colors.grey[300],
    canvasColor: Colors.grey[900],
    secondaryHeaderColor: Colors.grey[400],
    scaffoldBackgroundColor: Color(0xFF121212),
    extensions: <ThemeExtension<dynamic>>[
      ActivityHeatmapColors.dark(),
    ],
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF1E1E1E),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      elevation: 1,
      shadowColor: Colors.black26,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey[300],
      textTheme: ButtonTextTheme.primary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[200],
      foregroundColor: Colors.black,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.white70,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    primaryIconTheme: IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.grey[200]),
      foregroundColor: const WidgetStatePropertyAll(Colors.black),
      textStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 16, color: Colors.black)),
    )),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
        backgroundColor: WidgetStatePropertyAll(Colors.grey[200]),
      ),
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 2,
      shadowColor: Colors.black26,
    ),
    cardColor: Color(0xFF1E1E1E),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[600]!, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[400]!, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[600]!, width: 1.5),
      ),
      labelStyle: TextStyle(color: Colors.white),
    ),
    primaryTextTheme: textThemeDark(),
    textTheme: textThemeDark(),
    dialogTheme: DialogThemeData(backgroundColor: Color(0xFF1E1E1E)));

TextTheme textThemeLight() {
  return TextTheme(
    titleLarge: TextStyle(
      color: Colors.grey[900],
      fontSize: 23,
      height: 1.2,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.grey[900],
      fontSize: 20,
      height: 1.1,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Colors.grey[800],
      fontSize: 14,
    ),
    displayLarge: TextStyle(
      color: Colors.grey[900],
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.grey[700],
      fontSize: 12,
    ),
    displaySmall: TextStyle(
      color: Colors.grey[800],
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey[900],
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[800],
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      color: Colors.grey[700],
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      color: Colors.grey[900],
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: Colors.grey[800],
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(color: Colors.grey[700], fontSize: 12),
  );
}

TextTheme textThemeDark() {
  return TextTheme(
    titleLarge: TextStyle(
      color: Colors.grey[50],
      fontSize: 23,
      height: 1.2,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.grey[50],
      fontSize: 20,
      height: 1.1,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Colors.grey[100],
      fontSize: 14,
    ),
    displayLarge: TextStyle(
      color: Colors.grey[50],
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.grey[300],
      fontSize: 12,
    ),
    displaySmall: TextStyle(
      color: Colors.grey[100],
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey[50],
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[100],
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      color: Colors.grey[300],
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      color: Colors.grey[50],
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: Colors.grey[100],
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(color: Colors.grey[300], fontSize: 12),
  );
}
