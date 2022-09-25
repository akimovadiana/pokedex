import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/domain/repository/api_repository.dart';
import 'package:pokedex/data/repository/api_repository_impl.dart';
import 'package:pokedex/home/presentation/page/home_page.dart';
import 'package:pokedex/home/presentation/view_model/home_view_model.dart';
import 'package:pokedex/config/theme.dart';

void main() {
  GetIt.I.registerSingleton<ApiRepository>(ApiRepositoryImpl());
  GetIt.I.registerFactory<HomeViewModelImpl>(
      () => HomeViewModelImpl(GetIt.I.get()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: basicTheme(),
      home: const HomePage(),
    );
  }
}
