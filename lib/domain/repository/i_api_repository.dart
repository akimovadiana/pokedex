import 'package:pokedex/domain/entity/page_entity.dart';
import 'package:pokedex/domain/entity/pokemon_info_entity.dart';

abstract class IApiRepository {
  Future<PageEntity> getPokemons(int offset);

  Future<PokemonInfoEntity> getPokemonDetails([String? url]);
}
