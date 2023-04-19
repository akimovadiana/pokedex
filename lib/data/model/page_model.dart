import 'package:pokedex/data/model/pokemon_model.dart';

class PageModel {
  late final int count;
  late final List<PokemonModel> results;

  PageModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    final results = <PokemonModel>[];
    if (json['results']?.isNotEmpty ?? false) {
      json['results'].forEach((v) {
        results.add(PokemonModel.fromJson(v));
      });
    }
    this.results = results;
  }
}
