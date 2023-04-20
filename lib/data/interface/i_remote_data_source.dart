import 'package:pokedex/data/model/page_model.dart';
import 'package:pokedex/data/model/pokemon_info_model.dart';

abstract class IRemoteDataSource {
  Future<PageModel> getPokemons(int offset);

  Future<PokemonInfoModel> getPokemonDetails([String? url]);
}
