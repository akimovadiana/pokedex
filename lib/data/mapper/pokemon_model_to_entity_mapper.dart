import 'package:pokedex/data/model/pokemon_model.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';

abstract class PokemonModelToEntityMapper {
  static PokemonEntity execute(PokemonModel model) => PokemonEntity()
    ..name = model.name
    ..image = model.image
    ..height = model.height
    ..weight = model.weight
    ..types = model.types;
}
