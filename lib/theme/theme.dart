import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  // primarySwatch: Colors.green,
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 255, 230, 0),
      background: const Color.fromARGB(255, 31, 31, 31)),
  dividerTheme: const DividerThemeData(color: Colors.white24),
  useMaterial3: true,
  // dividerColor: Colors.white24,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 31, 31, 31),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Color.fromARGB(255, 223, 211, 211),
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
);
