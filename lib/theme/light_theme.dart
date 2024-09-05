import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  cardColor: Color.fromARGB(134, 225, 225, 225),
  // Customize light theme here
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color.fromRGBO(0, 150, 136, 1),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black54),
    bodySmall: TextStyle(color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
    ),
    filled: true,
  ),
);
