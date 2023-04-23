import 'dart:convert';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:http/http.dart' as http;

class RemoteDataSourcesImpl implements RemoteDataSources {
  final http.Client _repository;

  RemoteDataSourcesImpl(http.Client repository) : _repository = repository;

  @override
  Future<EventsDataDto> getRemoteData([int? params]) async {
    final url = Uri.parse(
        'https://fuksiarz.pl/rest/market/categories/multi/$params/events',);
    final response = await _repository
        .get(url, headers: {'Content-Type': 'application/json'});

    return EventsDataDto.fromJson(jsonDecode(response.body));
  }
  
  @override
  Future<QuickSearchResponseDto> getQuckSearchData([String? params]) {
    // TODO: implement getQuckSearchData
    throw UnimplementedError();
  }
  

}
