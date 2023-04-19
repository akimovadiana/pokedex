class PokemonModel {
  String? url;
  String? name;
  String? image;
  List<String>? types;
  String? height;
  String? weight;

  PokemonModel.fromJson(Map<String, dynamic> json) {
    this
      ..url = json['url']
      ..name = json['name']
      ..image = json['image']
      ..types = json['types']?.split(';')
      ..height = json['height']
      ..weight = json['weight'];
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
        'types': types?.join(';'),
        'height': height,
        'weight': weight,
      };
}
