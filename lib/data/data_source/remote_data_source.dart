import 'dart:convert';
import 'package:http/http.dart';
import 'package:pokedex/core/const/other.dart';
import 'package:pokedex/data/interface/i_remote_data_source.dart';
import 'package:pokedex/data/model/page_model.dart';
import 'package:pokedex/data/model/pokemon_info_model.dart';

class RemoteDataSource implements IRemoteDataSource {
  @override
  Future<PageModel> getPokemons(int offset) async {
    Response response = await get(Uri.parse('${Other.fullUrl}$offset'));
    var parsed = jsonDecode(response.body);
    return PageModel.fromJson(parsed);
  }

  @override
  Future<PokemonInfoModel> getPokemonDetails([String? url]) async {
    Response response = await get(Uri.parse(url ?? Other.defaultUrl));
    var parsed = jsonDecode(response.body);
    return PokemonInfoModel.fromJson(parsed);
  }
}
