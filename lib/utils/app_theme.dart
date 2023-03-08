import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_texts.dart';

ThemeData englishTheme = ThemeData(
    scaffoldBackgroundColor: mainColor,
    fontFamily: 'TiltNeon',
    appBarTheme:  const AppBarTheme(
        backgroundColor: mainColor,
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: style24
    ),
    textTheme: const TextTheme(
        bodyMedium: style24,
        bodyLarge: style20
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: black
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: green
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: black
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.red.withOpacity(0.2)
            )
        )
    )
);
ThemeData arabicTheme = ThemeData(
    fontFamily: 'NotoSansArabic',
    textTheme:  const TextTheme(
        bodyMedium: style24,
        bodyLarge: style20
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: black
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: green
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: black
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.red.withOpacity(0.2)
            )
        )
    )
);