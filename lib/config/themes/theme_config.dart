import 'package:flutter/material.dart';

// Use this if we want to have multiple themes
// Then we will have make appThemeData become a map
/*
enum AppTheme = {
  lightTheme,
  darkTheme
}

final appThemeData = {
  AppTheme.lightTheme: ThemeData(),
  AppTheme.darkTheme: ThemeData()
}
*/

const myRescueBeige = Color.fromARGB(255, 255, 244, 234);
const myRescueBlue = Color.fromARGB(255, 32, 55, 73);
const myRescueOrange = Color.fromARGB(255, 253, 113, 78);

// Define the details of the themes we specified
final appThemeData = ThemeData(
    backgroundColor: myRescueBeige,
    textTheme: const TextTheme(
        titleLarge:
            TextStyle(fontFamily: "Lexend", color: Colors.white, fontSize: 24),
        displaySmall:
            TextStyle(fontFamily: "Lexend", color: Colors.white, fontSize: 14)),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        primary: myRescueBlue,
        onPrimary: myRescueBeige,
        secondary: myRescueOrange,
        onSecondary: myRescueBeige,
        error: Colors.red[900],
        onError: Colors.white,
        background: myRescueBeige,
        onBackground: myRescueBlue,
        surface: myRescueBlue,
        onSurface: myRescueBeige));
