import 'package:http/http.dart';
import 'package:pokedex/config/const.dart';
import 'package:pokedex/domain/repository/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<Response> getPage([String? url]) async {
    Response response = await get(Uri.parse(url ?? defaultUrl));
    return response;
  }

  @override
  Future<Response> getPokemons(int offset) async {
    Response response = await get(Uri.parse(fullUrl + '$offset'));
    return response;
  }

  @override
  Future<Response> searchPokemons() async {
    Response response =
        await get(Uri.parse(defaultUrl + '?limit=100000&offset=0'));
    return response;
  }
}
