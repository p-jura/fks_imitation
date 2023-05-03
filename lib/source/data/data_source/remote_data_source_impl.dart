// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fuksiarz_imitation/core/errors/exceptions.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';

class RemoteDataSourcesImpl implements RemoteDataSources {
  final http.Client _repository;

  RemoteDataSourcesImpl(http.Client repository) : _repository = repository;

  @override
  Future<EventsDataDto> getRemoteData([int? params]) async {
    int category = params ?? 0;
    final url = Uri.parse(
      '${constants.API_URL_PREFIX}/${constants.API_URL_EVENTS_SUFFIX}/$category/events',
    );

    final response = await _repository.get(
      url,
      headers: constants.REQUEST_HEADER,
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
      areas: const [
        'CATEGORY',
        'LIVE',
        'PREMATCH_EVENT',
      ],
      languageCode: 'pl',
      limit: '5',
      mergeLanguages: 1,
      modes: const ['INFIX','PREFIX'],
      pattern: 'BAR',
    );

    final url = Uri.parse(
      '${constants.API_URL_PREFIX}/${constants.API_URL_QUICK_SEARCH_SUFFIX}',
    );
    final http.Response postResponse = await _repository.post(
      url,
      headers: constants.REQUEST_HEADER,
      body: jsonEncode(
        postRequest.toJson(),
      ),
    );
    if (postResponse.statusCode == 200) {
      print(json.decode(utf8.decode(postResponse.bodyBytes)));
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

  http.Client get repository => _repository;
}
