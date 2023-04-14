import 'package:pokedex/core/const/other.dart';
import 'package:pokedex/data/interface/i_remote_data_source.dart';
import 'package:pokedex/data/mapper/pokemon_model_to_entity_mapper.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/repository/i_api_repository.dart';

class ApiRepository implements IApiRepository {
  final IRemoteDataSource _remoteDataSource;

  const ApiRepository(
    this._remoteDataSource,
  );

  @override
  Future<Map<String, dynamic>> getPokemonDetails([String? url]) =>
      _remoteDataSource.getPokemonDetails(url ?? Other.defaultUrl);

  @override
  Future<List<PokemonEntity>> getPokemons(int offset) async {
    var list = await _remoteDataSource.getPokemons(offset);
    return list
        .map((model) => PokemonModelToEntityMapper.execute(model))
        .toList();
  }
}
