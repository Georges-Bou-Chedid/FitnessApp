import 'dart:ui';

import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData();

Color greyColor = const Color(0xFFEAEAEA);

Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100, 'Percent must be b/w 1&100');
  final f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}

Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100, 'Percent must be b/w 1&100');
  final p = percent / 100;
  return Color.fromARGB(
    c.alpha,
    c.red + ((255 - c.red) * p).round(),
    c.green + ((255 - c.green) * p).round(),
    c.blue + ((255 - c.blue) * p).round(),
  );
}

ThemeData blackTheme() =>
    ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      drawerTheme: DrawerThemeData(
        backgroundColor: const Color(0xFF323232),
        shadowColor: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFFFFFFFF)
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: const Color(0xFF323232),
        headerBackgroundColor: const Color(0xFF3FCC7C),
        headerForegroundColor: const Color(0xFF323232),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0)
        ),
        headerHeadlineStyle: const TextStyle(
            fontFamily: "Inter"
        ),
        headerHelpStyle: const TextStyle(
            fontFamily: "Inter"
        ),

        rangePickerBackgroundColor: const Color(0xFF323232),
        rangePickerShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0)
        ),
        rangePickerHeaderHelpStyle: const TextStyle(
          fontFamily: "Inter"
        ),
        rangePickerHeaderHeadlineStyle: const TextStyle(
          fontFamily: "Inter"
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: const Color(0xFF323232),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0)
        ),
        cancelButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF5AC8FA)),
          foregroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF5AC8FA)),
        ),
        confirmButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF5AC8FA)),
          foregroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF5AC8FA)),
        )
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF5AC8FA)), // Change the color as needed
        ),
        floatingLabelStyle: TextStyle(
          color: Color(0xFF5AC8FA), // Change the color as needed
        ),
      ),
      cardColor: const Color(0xFF323232),
      cardTheme: CardTheme(
        elevation: 4, // Add elevation for a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
          side: const BorderSide(
            color: Color(0xFFFFFFFF), // Border color
            width: 2.0, // Border width
          ),
        ),
        clipBehavior: Clip.hardEdge,
        shadowColor: const Color(0xFFFFFFFF)
      ),
      // brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF323232),
      tabBarTheme: const TabBarTheme(
        labelColor: Color(0xFFFFFFFF),
        unselectedLabelColor: Colors.black,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: Color(0xFFFFFFFF)), // Set the line width and color
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: "Inter",
          color: Color(0xFFFFFFFF)
        ),
        bodyMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF)
        ),
        bodySmall: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF)
        ),
        headlineLarge: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF)
        ),
        headlineMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF)
        ),
        headlineSmall: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF)
        ),
        titleLarge: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF)
        ),
        titleMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF)
        ),
        titleSmall: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF)
        ),
      ),
      dialogBackgroundColor: const Color(0xFF323232),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );

ThemeData lightTheme() =>
    ThemeData.light().copyWith(

    );