import 'dart:async';
import 'dart:convert';

import 'package:pokedex/domain/repository/api_repository.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:rxdart/subjects.dart';

abstract class HomeViewModel {
  Stream<ContentModel?> get dataStream;
  Future<void> getPage([bool isNext]);
}


class HomeViewModelImpl implements HomeViewModel {
  HomeViewModelImpl(this._apiRepository);

  final ApiRepository _apiRepository;
  final _behaviorSubject = BehaviorSubject<ContentModel?>();

  @override
  Stream<ContentModel?> get dataStream => _behaviorSubject.stream;

  @override
  Future<void> getPage([bool isNext = true]) async {
    String? url = isNext
        ? _behaviorSubject.valueOrNull?.next
        : _behaviorSubject.valueOrNull?.previous;
    _behaviorSubject.add(null);
    final resp = await _apiRepository.getPage(url);
    if (resp.statusCode == 200) {
      final body = json.decode(resp.body);
      if (body.isNotEmpty) {
        try {
          _behaviorSubject.add(ContentModel.fromJson(body));
        } catch (_) {}
      }
    }
  }
}
