import 'package:flutter/material.dart';
import 'package:pokedex/core/const/themes_data.dart';
import 'package:pokedex/injections/dependency_injections.dart';
import 'package:pokedex/presentation/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjections.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemesData.basicTheme,
      home: const HomePage(),
    );
  }
}
