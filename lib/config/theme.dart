import 'package:flutter/material.dart';
import 'package:pokedex/config/colors.dart';

ThemeData basicTheme() => ThemeData(
  appBarTheme: const AppBarTheme(
    color: ColorList.black,
    centerTitle: true,
  ),
);
