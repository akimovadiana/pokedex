import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:pokedex/database/db_helper.dart';
import 'package:pokedex/domain/repository/api_repository.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class HomeViewModel {
  // int? get dataStreamCount;

  Stream<List<PokemonModel>?> get dataStream;

  Stream<List<PokemonModel>?> get searchStream;

  // Future<void> getPage([bool isNext]);

  Future<void> getPokemons();

  TextEditingController get queryController;

  void startListen();

  void stopListen();
}

class HomeViewModelImpl implements HomeViewModel {
  HomeViewModelImpl(this._apiRepository);

  final ApiRepository _apiRepository;

  // final DBHelper _database;

  // int? get dataStreamCount => _behaviorSubject.valueOrNull?.length;

  final _dataSubject = BehaviorSubject<List<PokemonModel>?>();
  final _searchSubject = BehaviorSubject<List<PokemonModel>?>();

  // int _index = 0;
  // bool _isNext = true;

  @override
  Stream<List<PokemonModel>?> get dataStream => _dataSubject.stream;

  @override
  Stream<List<PokemonModel>?> get searchStream => _searchSubject.stream;

  // @override
  // Future<void> getPage([bool isNext = true]) async {
  //   String? url = isNext
  //       ? _behaviorSubject.valueOrNull?.next
  //       : _behaviorSubject.valueOrNull?.previous;
  //   if (!_behaviorSubject.hasError) {
  //     _behaviorSubject.add(null);
  //   }
  //   try {
  //     final resp = await _apiRepository.getPage(url);
  //     if (resp.statusCode == 200) {
  //       final body = json.decode(resp.body);
  //       if (body.isNotEmpty) {
  //         final model = ContentModel()..fromJson(body);
  //         _behaviorSubject.add(model);
  //         _index = 0;
  //         if (model.results?.isNotEmpty ?? false) {
  //           for (ModelOfDB item in model.results!) {
  //             await _database.insert(DBTables.pokemons, item);
  //           }
  //         }
  //       }
  //     } else {
  //       _onError(isNext);
  //     }
  //   } catch (e) {
  //     _onError(isNext);
  //   }
  // }

  @override
  Future<void> getPokemons() async {
    try {
      final resp = await _apiRepository
          .getPokemons(_dataSubject.valueOrNull?.length ?? 0);
      if (resp.statusCode == 200) {
        final map = json.decode(resp.body);
        if (map.isNotEmpty) {
          if (map['results'] != null) {
            final results = <PokemonModel>[];
            map['results'].forEach((v) {
              results.add(PokemonModel()..fromJson(v));
            });
            _dataSubject.add([...(_dataSubject.valueOrNull ?? []), ...results]);
          }
        }
      }
    } catch (e) {
      _onError();
    }
  }

  final queryController = TextEditingController();
  final _querySubject = BehaviorSubject<String>();
  StreamSubscription? _subscription;

  @override
  void startListen() {
    _searchSubject.add(null);
    queryController.addListener(() {
      _querySubject.add(queryController.value.text);
    });
    _subscription = _querySubject
        .debounce((_) => TimerStream(true, Duration(seconds: 1)))
        .listen(_searchPokemons);
  }

  @override
  void stopListen() => _subscription?.cancel();

  Future<void> _searchPokemons(String query) async {
    _searchSubject.add(null);
    try {
      if (query.isNotEmpty) {
        final resp = await _apiRepository.searchPokemons();
        if (resp.statusCode == 200) {
          final map = json.decode(resp.body);
          if (map.isNotEmpty) {
            if (map['results'] != null) {
              final results = <PokemonModel>[];
              map['results'].forEach((v) {
                results.add(PokemonModel()..fromJson(v));
              });
              _searchSubject.add(results
                  .where((p) => (p.name?.toLowerCase() ?? '')
                      .contains(query.toLowerCase()))
                  .toList());
            }
          }
        }
      }
    } catch (e) {
      _onError();
    }
  }

  Future<void> _onError([bool isNext = true]) async {
    // _isNext = isNext;
    // await _database
    //     .getAll(DBTables.pokemons, isNext, _index, PokemonModel)
    //     .then((list) {
    //   if (list.isNotEmpty) {
    //     _behaviorSubject.addError(list);
    //     if (_isNext) {
    //       _index += list.length;
    //     } else {
    //       _index -= list.length;
    //     }
    //   }
    // });
  }
}
