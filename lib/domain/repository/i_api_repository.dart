import 'package:pokedex/domain/entity/page_entity.dart';
import 'package:pokedex/domain/entity/pokemon_info_entity.dart';

abstract class IApiRepository {
  Future<PokemonInfoEntity> getPokemonDetails([String? url]);

  Future<PageEntity> getPokemons(int offset);
}
