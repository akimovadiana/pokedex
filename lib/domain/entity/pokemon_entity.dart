class PokemonEntity {
  String? name;
  String? url;

  String? image;
  List<String>? types;
  String? height;
  String? weight;

  PokemonEntity();

  PokemonEntity.fromJson(Map<String, dynamic> json) {
    this
      ..url = json['url']
      ..name = json['name']
      ..image = json['image']
      ..types = json['types']?.split(';')
      ..height = json['height']
      ..weight = json['weight'];
  }

  void extendFromJson(Map<String, dynamic> json) {
    image = json['sprites']['other']['home']['front_default'];
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
