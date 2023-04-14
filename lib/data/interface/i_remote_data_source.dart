import 'package:pokedex/data/model/pokemon_model.dart';

abstract class IRemoteDataSource {
  Future<Map<String, dynamic>> getPokemonDetails([String? url]);

  Future<List<PokemonModel>> getPokemons(int offset);
}
