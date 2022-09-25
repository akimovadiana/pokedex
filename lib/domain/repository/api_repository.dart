import 'package:http/http.dart';

abstract class ApiRepository {
  Future<Response> getPage([String? url]);
}