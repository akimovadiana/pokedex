import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/repository/i_api_repository.dart';

class GetPokemonsUseCase {
  final IApiRepository _apiRepository;

  GetPokemonsUseCase(this._apiRepository);

  Future<List<PokemonEntity>> execute(int offset) =>
      _apiRepository.getPokemons(offset);
}
