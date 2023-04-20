import 'package:pokedex/core/const/other.dart';
import 'package:pokedex/data/interface/i_remote_data_source.dart';
import 'package:pokedex/data/mapper/page_model_to_entity_mapper.dart';
import 'package:pokedex/data/mapper/pokemon_info_model_to_entity_mapper.dart';
import 'package:pokedex/domain/entity/page_entity.dart';
import 'package:pokedex/domain/entity/pokemon_info_entity.dart';
import 'package:pokedex/domain/repository/i_api_repository.dart';

class ApiRepository implements IApiRepository {
  final IRemoteDataSource _remoteDataSource;

  const ApiRepository(
    this._remoteDataSource,
  );

  @override
  Future<PageEntity> getPokemons(int offset) async {
    var model = await _remoteDataSource.getPokemons(offset);
    return PageModelToEntityMapper.execute(model);
  }

  @override
  Future<PokemonInfoEntity> getPokemonDetails([String? url]) async {
    var model =
        await _remoteDataSource.getPokemonDetails(url ?? Other.defaultUrl);
    return PokemonInfoModelToEntityMapper.execute(model);
  }
}
