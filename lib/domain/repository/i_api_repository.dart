import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/entity/pokemon_info_entity.dart';

abstract class IApiRepository {
  Future<PokemonInfoEntity> getPokemonDetails([String? url]);

  Future<List<PokemonEntity>> getPokemons(int offset);
}
