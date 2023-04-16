import 'package:pokedex/domain/entity/pokemon_info_entity.dart';
import 'package:pokedex/domain/repository/i_api_repository.dart';

class GetPokemonDetailsUseCase {
  final IApiRepository _apiRepository;

  GetPokemonDetailsUseCase(this._apiRepository);

  Future<PokemonInfoEntity> execute([String? url]) =>
      _apiRepository.getPokemonDetails(url);
}
