import 'dart:async';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/entity/pokemon_info_entity.dart';
import 'package:pokedex/domain/use_case/get_pokemon_details_use_case.dart';
import 'package:rxdart/subjects.dart';

abstract class IInfoCardBloc {
  Stream<PokemonInfoEntity?> get dataStream;

  Future<void> getInfo(PokemonEntity entity);
}

class InfoCardBloc implements IInfoCardBloc {
  InfoCardBloc(this._getPokemonDetailsUseCase);

  final GetPokemonDetailsUseCase _getPokemonDetailsUseCase;

  final _behaviorSubject = BehaviorSubject<PokemonInfoEntity?>();

  @override
  Stream<PokemonInfoEntity?> get dataStream => _behaviorSubject.stream;

  @override
  Future<void> getInfo(PokemonEntity entity) async {
    _behaviorSubject.add(null);
    {
      try {
        var pokemonInfoEntity =
            await _getPokemonDetailsUseCase.execute(entity.url);
        _behaviorSubject.add(pokemonInfoEntity);
      } catch (e) {
        print(e);
      }
    }
  }
}
