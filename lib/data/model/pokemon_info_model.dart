class PokemonInfoModel {
  String? name;

  String? image;
  List<String>? types;
  String? height;
  String? weight;

  PokemonInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
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

  Map<String, dynamic> toJson() => {
        'name': name,
        'types': types?.join(';'),
        'height': height,
        'weight': weight,
      };
}
