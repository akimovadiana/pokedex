import 'package:flutter/material.dart';
import 'package:pokedex/config/colors.dart';

ThemeData basicTheme() => ThemeData(
      appBarTheme: const AppBarTheme(
        color: ColorList.black,
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
