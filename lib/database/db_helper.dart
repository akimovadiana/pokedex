import 'dart:async';

import 'package:path/path.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:sqflite/sqflite.dart';

class DBTables {
  static const String content = 'content';
  static const String pokemons = 'pokemons';
}

abstract class ModelOfDB {
  void fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

abstract class DBHelper {
  Future<void> dropDB();

  Future<Database> initDB();

  Future<int> insertList(String table, List<ModelOfDB> list);

  Future<int> insert(String table, ModelOfDB model);

  Future<List<dynamic>> getAll(
      String table, bool? isNext, int? index, Type type);
}

class DBHelperImpl implements DBHelper {
  @override
  Future<void> dropDB() async {
    await deleteDatabase(
        join(await getDatabasesPath(), 'pokemons_database.db'));
  }

  @override
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'pokemons_database.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        // await db.execute(
        //   "CREATE TABLE IF NOT EXISTS ${DBTables.content}("
        //   "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        //   "count INTEGER,"
        //   "next TEXT,"
        //   "previous TEXT, results TEXT"
        //   ")",
        // );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS ${DBTables.pokemons}("
          "name TEXT PRIMARY KEY,"
          "url TEXT,"
          "types TEXT,"
          "height TEXT,"
          "weight TEXT,"
          "contentID INTEGER"
          // "FOREIGN KEY (contentID) REFERENCES content (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          ")",
        );
      },
    );
  }

  @override
  Future<int> insertList(String table, List<ModelOfDB> list) async {
    int result = 0;
    final Database db = await initDB();
    for (ModelOfDB model in list) {
      result = await db.insert(table, model.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  @override
  Future<int> insert(String table, ModelOfDB model) async {
    int result = 0;
    final Database db = await initDB();

    result = await db.insert(table, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  @override
  Future<List<dynamic>> getAll(
      String table, bool? isNext, int? index, Type type) async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult = await db.query(table,
        limit: 20,
        offset: index == null || (index == 20 && isNext == false)
            ? 0
            : (index > 20 && isNext == false)
                ? index - 20
                : index);
    return queryResult.map((e) {
      dynamic obj;
      switch (type) {
        case PokemonModel:
          obj = PokemonModel();
          break;
        default:
          obj = ContentModel();
      }
      return obj..fromJson(e);
    }).toList();
  }
}
