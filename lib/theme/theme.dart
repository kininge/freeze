import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
);
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(39, 199, 109, 1.0),
    onPrimary: Color.fromRGBO(85, 238, 153, 1.0),
    secondary: Color.fromRGBO(32, 33, 35, 1.0),
    onSecondary: Color.fromRGBO(153, 155, 155, 1.0),
    error: Color.fromRGBO(176, 0, 32, 1.0),
    onError: Color.fromRGBO(242, 242, 242, 1.0),
    background: Color.fromRGBO(242, 242, 242, 1.0),
    onBackground: Color.fromRGBO(32, 33, 35, 1.0),
    surface: Color.fromRGBO(242, 242, 242, 1.0),
    onSurface: Color.fromRGBO(210, 210, 210, 1.0),
  ),
  actionIconTheme: const ActionIconThemeData(),
  appBarTheme: const AppBarTheme(),
  bottomAppBarTheme: const BottomAppBarTheme(),
  buttonTheme: const ButtonThemeData(),
  cardTheme: const CardTheme(),
  textTheme: GoogleFonts.outfitTextTheme(),
);
