import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/repository/i_api_repository.dart';
import 'package:pokedex/domain/use_case/get_pokemons_use_case.dart';
import 'package:rxdart/rxdart.dart';

abstract class IHomeBloc {
  // int? get dataStreamCount;

  Stream<List<PokemonEntity>?> get dataStream;

  Stream<List<PokemonEntity>?> get searchStream;

  // Future<void> getPage([bool isNext]);

  Future<void> getPokemons();

  TextEditingController get queryController;

  void startListen();

  void stopListen();
}

class HomeBloc implements IHomeBloc {
  final IApiRepository _apiRepository;
  final GetPokemonsUseCase _getPokemonsUseCase;

  HomeBloc(
    this._apiRepository,
    this._getPokemonsUseCase,
  );

  final _dataSubject = BehaviorSubject<List<PokemonEntity>?>();
  final _searchSubject = BehaviorSubject<List<PokemonEntity>?>();

  @override
  Stream<List<PokemonEntity>?> get dataStream => _dataSubject.stream;

  @override
  Stream<List<PokemonEntity>?> get searchStream => _searchSubject.stream;

  @override
  Future<void> getPokemons() async {
    try {
      var results = await _getPokemonsUseCase
          .execute(_dataSubject.valueOrNull?.length ?? 0);
      _dataSubject.add([...(_dataSubject.valueOrNull ?? []), ...results]);
    } catch (e) {
      _onError();
    }
  }

  final queryController = TextEditingController();
  final _querySubject = BehaviorSubject<String>();
  StreamSubscription? _subscription;

  @override
  void startListen() {
    // _searchSubject.add(null);
    // queryController.addListener(() {
    //   _querySubject.add(queryController.value.text);
    // });
    // _subscription = _querySubject
    //     .debounce((_) => TimerStream(true, Duration(seconds: 1)))
    //     .listen(_searchPokemons);
  }

  @override
  void stopListen() => _subscription?.cancel();

  // Future<void> _searchPokemons(String query) async {
  //   _searchSubject.add(null);
  //   try {
  //     if (query.isNotEmpty) {
  //       final resp = await _apiRepository.searchPokemons();
  //       if (resp.statusCode == 200) {
  //         final map = json.decode(resp.body);
  //         if (map.isNotEmpty) {
  //           if (map['results'] != null) {
  //             final results = <PokemonModel>[];
  //             map['results'].forEach((v) {
  //               results.add(PokemonModel()..fromJson(v));
  //             });
  //             _searchSubject.add(results
  //                 .where((p) => (p.name?.toLowerCase() ?? '')
  //                     .contains(query.toLowerCase()))
  //                 .toList());
  //           }
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     _onError();
  //   }
  // }

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
