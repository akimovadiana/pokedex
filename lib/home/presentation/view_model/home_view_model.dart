import 'dart:async';
import 'dart:convert';

import 'package:pokedex/database/db_helper.dart';
import 'package:pokedex/domain/repository/api_repository.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:rxdart/subjects.dart';

abstract class HomeViewModel {
  Stream<ContentModel?> get dataStream;

  Future<void> getPage([bool isNext]);
}

class HomeViewModelImpl implements HomeViewModel {
  HomeViewModelImpl(this._apiRepository, this._database);

  final ApiRepository _apiRepository;
  final DBHelper _database;

  final _behaviorSubject = BehaviorSubject<ContentModel?>();

  int _index = 0;
  bool _isNext = true;

  @override
  Stream<ContentModel?> get dataStream => _behaviorSubject.stream;

  @override
  Future<void> getPage([bool isNext = true]) async {
    String? url = isNext
        ? _behaviorSubject.valueOrNull?.next
        : _behaviorSubject.valueOrNull?.previous;
    if (!_behaviorSubject.hasError) {
      _behaviorSubject.add(null);
    }
    try {
      final resp = await _apiRepository.getPage(url);
      if (resp.statusCode == 200) {
        final body = json.decode(resp.body);
        if (body.isNotEmpty) {
          final model = ContentModel()..fromJson(body);
          _behaviorSubject.add(model);
          _index = 0;
          if (model.results?.isNotEmpty ?? false) {
            for (ModelOfDB item in model.results!) {
              await _database.insert(DBTables.pokemons, item);
            }
          }
        }
      } else {
        _onError(isNext);
      }
    } catch (e) {
      _onError(isNext);
    }
  }

  Future<void> _onError([bool isNext = true]) async {
    _isNext = isNext;
    await _database
        .getAll(DBTables.pokemons, isNext, _index, PokemonModel)
        .then((list) {
      if (list.isNotEmpty) {
        _behaviorSubject.addError(list);
        if (_isNext) {
          _index += list.length;
        } else {
          _index -= list.length;
        }
      }
    });
  }
}
