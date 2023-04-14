import 'dart:async';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/use_case/get_pokemon_details_use_case.dart';
import 'package:rxdart/subjects.dart';

abstract class IInfoCardBloc {
  Stream<PokemonEntity?> get dataStream;

  Future<void> getInfo(PokemonEntity entity);
}

class InfoCardBloc implements IInfoCardBloc {
  InfoCardBloc(this._getPokemonDetailsUseCase);

  final GetPokemonDetailsUseCase _getPokemonDetailsUseCase;

  // final DBHelper _database;

  final _behaviorSubject = BehaviorSubject<PokemonEntity?>();

  @override
  Stream<PokemonEntity?> get dataStream => _behaviorSubject.stream;

  @override
  Future<void> getInfo(PokemonEntity entity) async {
    _behaviorSubject.add(null);
    {
      try {
        var map = await _getPokemonDetailsUseCase.execute(entity.url);
        _behaviorSubject.add(entity..extendFromJson(map));
        // await _database.insert(DBTables.pokemons, model);
      } catch (e) {}
    }
  }
}
