import 'package:pokedex/domain/entity/pokemon_entity.dart';

class PageEntity {
  final int count;
  final List<PokemonEntity> results;

  PageEntity({required this.count, required this.results});
}
