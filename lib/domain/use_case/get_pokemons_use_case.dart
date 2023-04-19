import 'package:pokedex/domain/entity/page_entity.dart';
import 'package:pokedex/domain/repository/i_api_repository.dart';

class GetPokemonsUseCase {
  final IApiRepository _apiRepository;

  GetPokemonsUseCase(this._apiRepository);

  Future<PageEntity> execute(int offset) => _apiRepository.getPokemons(offset);
}
