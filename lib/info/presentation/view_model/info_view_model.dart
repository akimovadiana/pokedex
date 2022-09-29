import 'dart:async';
import 'dart:convert';

import 'package:pokedex/database/db_helper.dart';
import 'package:pokedex/domain/repository/api_repository.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:rxdart/subjects.dart';

abstract class InfoViewModel {
  Stream<PokemonModel?> get dataStream;

  Future<void> getInfo(PokemonModel model);
}

class InfoViewModelImpl implements InfoViewModel {
  InfoViewModelImpl(this._apiRepository, this._database);

  final ApiRepository _apiRepository;
  final DBHelper _database;

  final _behaviorSubject = BehaviorSubject<PokemonModel?>();

  @override
  Stream<PokemonModel?> get dataStream => _behaviorSubject.stream;

  @override
  Future<void> getInfo(PokemonModel model) async {
    _behaviorSubject.add(null);
    final resp = await _apiRepository.getPage(model.url);
    if (resp.statusCode == 200) {
      final body = json.decode(resp.body);
      if (body.isNotEmpty) {
        try {
          _behaviorSubject.add(model..extendFromJson(body));
          await _database.insert(DBTables.pokemons, model);
        } catch (e) {}
      }
    }
  }
}
