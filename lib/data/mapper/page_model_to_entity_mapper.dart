import 'package:pokedex/data/mapper/pokemon_model_to_entity_mapper.dart';
import 'package:pokedex/data/model/page_model.dart';
import 'package:pokedex/domain/entity/page_entity.dart';

abstract class PageModelToEntityMapper {
  static PageEntity execute(PageModel model) => PageEntity(
        count: model.count,
        results: model.results
            .map((model) => PokemonModelToEntityMapper.execute(model))
            .toList(),
      );
}
