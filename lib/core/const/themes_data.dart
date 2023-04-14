import 'package:flutter/material.dart';
import 'package:pokedex/core/const/app_colors.dart';

abstract class ThemesData {
  static ThemeData get basicTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.black,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      );
}
