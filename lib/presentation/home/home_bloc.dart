import 'dart:async';
import 'package:pokedex/core/const/other.dart';
import 'package:pokedex/domain/entity/page_entity.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/use_case/get_pokemons_use_case.dart';
import 'package:pokedex/domain/utils/numeric_util.dart';
import 'package:rxdart/rxdart.dart';

abstract class IHomeBloc {
  Stream<List<PokemonEntity>?> get dataStream;

  Stream<int?> get pageCountStream;

  int get currentPage;

  Future<void> getPokemons();

  Future<void> toPreviousPage();

  Future<void> toNextPage();
}

class HomeBloc implements IHomeBloc {
  final GetPokemonsUseCase _getPokemonsUseCase;

  HomeBloc(
    this._getPokemonsUseCase,
  );

  final _dataSubject = BehaviorSubject<List<PokemonEntity>?>();
  final _pageCountSubject = BehaviorSubject<int?>();

  @override
  Stream<List<PokemonEntity>?> get dataStream => _dataSubject.stream;

  @override
  Stream<int?> get pageCountStream => _pageCountSubject.stream;

  int _currentPage = 0;

  int get currentPage => _currentPage;

  final List<PokemonEntity> _pokemonEntityList = [];

  @override
  Future<void> getPokemons() async {
    try {
      PageEntity page =
          await _getPokemonsUseCase.execute(_pokemonEntityList.length);
      _pageCountSubject.add(NumericUtil.getPageByCount(page.count));

      _pokemonEntityList.addAll(page.results);
      if (_pokemonEntityList.isNotEmpty) {
        _sendList();
      }
    } catch (e) {
      _onError();
    }
  }

  Future<void> _onError() async {}

  @override
  Future<void> toNextPage() async {
    if (_currentPage + 1 < (_pageCountSubject.valueOrNull ?? 0)) {
      _currentPage++;
      if (_currentPage * Other.limit < _pokemonEntityList.length) {
        _sendList();
      } else {
        await getPokemons();
      }
    }
  }

  @override
  Future<void> toPreviousPage() async {
    if (_currentPage > 0) {
      _currentPage--;
      _sendList();
    }
  }

  void _sendList() {
    int end = (_currentPage + 1) * Other.limit;

    if (end > _pokemonEntityList.length) end = _pokemonEntityList.length;
    List<PokemonEntity> list = _pokemonEntityList
        .getRange(
          _currentPage * Other.limit,
          end,
        )
        .toList();
    _dataSubject.add(list);
  }
}
