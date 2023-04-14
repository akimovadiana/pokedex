import 'package:pokedex/domain/entity/pokemon_entity.dart';

abstract class IApiRepository {
  Future<Map<String, dynamic>> getPokemonDetails([String? url]);

  Future<List<PokemonEntity>> getPokemons(int offset);
}
