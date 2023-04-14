import 'package:pokedex/domain/repository/i_api_repository.dart';

class GetPokemonDetailsUseCase {
  final IApiRepository _apiRepository;

  GetPokemonDetailsUseCase(this._apiRepository);

  Future<Map<String, dynamic>> execute([String? url]) =>
      _apiRepository.getPokemonDetails(url);
}
