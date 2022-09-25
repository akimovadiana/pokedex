import 'package:http/http.dart';
import 'package:pokedex/config/const.dart';
import 'package:pokedex/domain/repository/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<Response> getPage([String? url]) async {
    Response response = await get(Uri.parse(url ?? defaultUrl));
    return response;
  }
}