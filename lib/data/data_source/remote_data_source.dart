import 'dart:convert';
import 'package:http/http.dart';
import 'package:pokedex/core/const/other.dart';
import 'package:pokedex/data/interface/i_remote_data_source.dart';
import 'package:pokedex/data/model/pokemon_model.dart';

class RemoteDataSource implements IRemoteDataSource {
  @override
  Future<List<PokemonModel>> getPokemons(int offset) async {
    Response response = await get(Uri.parse('${Other.fullUrl}$offset'));
    var parsed = jsonDecode(response.body);
    final results = <PokemonModel>[];
    if (parsed['results']?.isNotEmpty ?? false) {
      parsed['results'].forEach((v) {
        results.add(PokemonModel()..fromJson(v));
      });
    }
    return results;
  }

  @override
  Future<Map<String, dynamic>> getPokemonDetails([String? url]) async {
    Response response = await get(Uri.parse(url ?? Other.defaultUrl));
    return jsonDecode(response.body);
  }
}
