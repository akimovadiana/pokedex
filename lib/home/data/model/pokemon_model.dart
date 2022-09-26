class ContentModel {
  int? count;
  String? next;
  String? previous;
  List<PokemonModel>? results;

  ContentModel({this.count, this.next, this.previous, this.results});

  ContentModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <PokemonModel>[];
      json['results'].forEach((v) {
        results!.add(PokemonModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PokemonModel {
  String? name;
  String? url;

  String? image;
  List<dynamic>? types;
  String? height;
  String? weight;

  PokemonModel({this.name, this.url, this.image, this.types, this.height, this.weight});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  void extendFromJson(Map<String, dynamic> json) {
    image = json['image'];
    types = json['types'];
    height = json['height'].toString();
    weight = json['weight'].toString();
  }
}