import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: const Color(0xFF4169E1),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'SourceSansPro',
          fontFamilyFallback: ['Roboto']),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontFamily: 'SourceSansPro',
          fontFamilyFallback: ['Roboto']),
      bodySmall: TextStyle(
          fontSize: 12,
          fontFamily: 'SourceSansPro',
          fontFamilyFallback: ['Roboto']),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 2, color: Colors.black),
      ),
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF4169E1)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
    colorScheme: const ColorScheme(
      primary: Color(0xFF4169E1),
      secondary: Color.fromARGB(255, 232, 234, 244),
      surface: Colors.white,
      background: Color(0xFFF4FFFE),
      error: Color(0xFFB00020),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ));
