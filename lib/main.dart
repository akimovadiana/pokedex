import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// import 'package:pokedex/database/db_helper.dart';
import 'package:pokedex/domain/repository/api_repository.dart';
import 'package:pokedex/data/repository/api_repository_impl.dart';
import 'package:pokedex/home/presentation/page/home_page.dart';
import 'package:pokedex/home/presentation/view_model/home_view_model.dart';
import 'package:pokedex/config/theme.dart';
import 'package:pokedex/info/presentation/view_model/info_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // final DBHelperImpl dataBase = DBHelperImpl();

  // GetIt.I.registerSingleton<DBHelper>(dataBase);
  GetIt.I.registerSingleton<ApiRepository>(ApiRepositoryImpl());
  GetIt.I
      .registerFactory<HomeViewModel>(() => HomeViewModelImpl(GetIt.I.get()));
  GetIt.I.registerSingleton<InfoViewModel>(InfoViewModelImpl(GetIt.I.get()));

  // dataBase.initDB();

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
