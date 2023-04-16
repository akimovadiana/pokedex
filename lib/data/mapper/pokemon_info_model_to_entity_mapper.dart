import 'package:pokedex/data/model/pokemon_info_model.dart';
import 'package:pokedex/domain/entity/pokemon_info_entity.dart';

abstract class PokemonInfoModelToEntityMapper {
  static PokemonInfoEntity execute(PokemonInfoModel model) =>
      PokemonInfoEntity()
        ..name = model.name
        ..image = model.image
        ..height = model.height
        ..weight = model.weight
        ..types = model.types;
}
