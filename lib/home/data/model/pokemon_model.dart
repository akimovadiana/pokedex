import 'package:pokedex/database/db_helper.dart';

class ContentModel implements ModelOfDB {
  int? count;
  String? next;
  String? previous;
  List<PokemonModel>? results;

  @override
  void fromJson(Map<String, dynamic> json) {
    this
      ..count = json['count']
      ..next = json['next']
      ..previous = json['previous'];
    if (json['results'] != null) {
      final results = <PokemonModel>[];
      json['results'].forEach((v) {
        results.add(PokemonModel()..fromJson(v));
      });
      this.results = results;
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        // 'results': results?.map((v) => v.toJson()).toList(),
      };
}

class PokemonModel implements ModelOfDB {
  String? name;
  String? url;

  String? image;
  List<String>? types;
  String? height;
  String? weight;

  @override
  void fromJson(Map<String, dynamic> json) {
    this
      ..url = json['url']
      ..name = json['name']
      ..types = json['types']?.split(';')
      ..height = json['height']
      ..weight = json['weight'];
  }

  @override
  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
        'types': types?.join(';'),
        'height': height,
        'weight': weight,
      };

  void extendFromJson(Map<String, dynamic> json) {
    image = json['image'];
    height = json['height'].toString();
    weight = json['weight'].toString();

    if (json['types']?.isNotEmpty) {
      final list = <String>[];
      for (var item in json['types']) {
        list.add(item['type']['name'] ?? '');
      }
      types = list;
    }
  }
}