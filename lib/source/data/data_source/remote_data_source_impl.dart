// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:fuksiarz_imitation/core/errors/exceptions.dart';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:http/http.dart' as http;

const QUICKSEARCHURI = 'https://fuksiarz.pl/rest/search/events/quick-search';
const HEADERS = {
  'Content-Type': 'application/json',
  'Request-Language': 'en',
};

class RemoteDataSourcesImpl implements RemoteDataSources {
  final http.Client _repository;

  RemoteDataSourcesImpl(http.Client repository) : _repository = repository;

  @override
  Future<EventsDataDto> getRemoteData([int? params]) async {
    int categories;
    if (params == null) {
      categories = 1;
    } else {
      categories = params;
    }
    final url = Uri.parse(
      'https://fuksiarz.pl/rest/market/categories/multi/$categories/events',
    );

    final response = await _repository.get(
      url,
      headers: HEADERS,
    );
    if (response.statusCode == 200) {
      return EventsDataDto.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
    } else {
      throw ServerException(
        response.statusCode,
        response.reasonPhrase,
      );
    }
  }

  @override
  Future<QuickSearchResponseDto> getQuckSearchData(String params) async {
    final QuickSearchRequest postRequest = QuickSearchRequest(
      areas: null,
      languageCode: null,
      limit: 20,
      mergeLanguages: null,
      modes: null,
      pattern: params,
    );

    final url = Uri.parse(QUICKSEARCHURI);
    final http.Response postResponse = await _repository.post(
      url,
      headers: HEADERS,
      body: jsonEncode(
        postRequest.toJson(),
      ),
    );
    if (postResponse.statusCode == 200) {
      return QuickSearchResponseDto.fromJson(
        json.decode(
          utf8.decode(postResponse.bodyBytes),
        ),
      );
    } else {
      throw ServerException(
        postResponse.statusCode,
        postResponse.reasonPhrase,
      );
    }
  }
}
