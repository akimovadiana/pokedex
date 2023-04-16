import 'package:pokedex/data/model/pokemon_info_model.dart';
import 'package:pokedex/data/model/pokemon_model.dart';

abstract class IRemoteDataSource {
  Future<PokemonInfoModel> getPokemonDetails([String? url]);

  Future<List<PokemonModel>> getPokemons(int offset);
}
