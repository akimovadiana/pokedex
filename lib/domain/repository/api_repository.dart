import 'package:http/http.dart';

abstract class ApiRepository {
  Future<Response> getPage([String? url]);

  Future<Response> getPokemons(int offset);

  Future<Response> searchPokemons();
}
