import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/core/errors/exceptions.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source_impl.dart';
import '../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks(
  [
    MockSpec<http.Client>(onMissingStub: OnMissingStub.returnDefault),
  ],
)
import './remote_data_source_impl_test.mocks.dart';

void main() {
  late MockClient mockedHttpClient;
  late RemoteDataSourcesImpl dataSourcesImpl;

  setUp(
    () {
      mockedHttpClient = MockClient();
      dataSourcesImpl = RemoteDataSourcesImpl(mockedHttpClient);
    },
  );
  group(
    'data_source - getRemoteData()',
    () {
      final dtoStringFixture = readFixture(
        'remote_data_simple_fixture.json',
        'remote_data_fixtures',
      );
      final dtoStringWithErrorFixture = readFixture(
        'remote_data_simple_error_fixture.json',
        'remote_data_fixtures',
      );
      const tEventDataDto =
          EventsDataDto(code: 200, description: 'OK.', data: []);
      final http.Response httpResponse = http.Response(dtoStringFixture, 200);
      final http.Response httpErrorResponse =
          http.Response(dtoStringWithErrorFixture, 500);

      const int tCat = 1;
      final url = Uri.parse(
        'https://fuksiarz.pl/rest/market/categories/multi/$tCat/events',
      );

      test(
        'veryfieing proper category is selected',
        () async {
          when(
            mockedHttpClient.get(
              any,
              headers: anyNamed('headers'),
            ),
          ).thenAnswer((_) async => httpResponse);

          await dataSourcesImpl.getRemoteData(tCat);

          verify(
            mockedHttpClient.get(
              url,
              headers: anyNamed('headers'),
            ),
          );
        },
      );
      test(
        'when getRemoteData() is called should return DTO',
        () async {
          when(
            mockedHttpClient.get(
              any,
              headers: anyNamed('headers'),
            ),
          ).thenAnswer((_) async => httpResponse);
          final response = await dataSourcesImpl.getRemoteData(tCat);
          expect(
            response.code,
            200,
          );
          expect(
            response,
            equals(tEventDataDto),
          );
          expect(
            response.runtimeType,
            equals(EventsDataDto),
          );
        },
      );
      test(
        'when getRemoteData() is called should throw an exeption',
        () async {
          when(
            mockedHttpClient.get(
              any,
              headers: anyNamed('headers'),
            ),
          ).thenAnswer((_) async => httpErrorResponse);

          final call = dataSourcesImpl.getRemoteData;

          expect(
            () => call(tCat),
            throwsA(
              const TypeMatcher<ServerException>(),
            ),
          );
        },
      );
    },
  );
  group(
    'data_source - getQuckSearchData()',
    () {
      final responseFixture =
          readFixture('quick_search_response.json', 'quick_search_fixtures');
      final http.Response httpQueryResponse =
          http.Response(responseFixture, 200);
      final http.Response httpQueryResponseWithError =
          http.Response('something went wrong', 400);

      const String searchPattern = 'test';

      const postRequest = QuickSearchRequest(
        areas: null,
        languageCode: null,
        limit: '20',
        mergeLanguages: null,
        modes: null,
        pattern: searchPattern,
      );

      test(
        'veryfying if post request is properly sended',
        () async {
          when(
            mockedHttpClient.post(
              any,
            ),
          ).thenAnswer((_) async => httpQueryResponse);

          await dataSourcesImpl.getQuckSearchData(searchPattern);

          verify(
            mockedHttpClient.post(
              any,
            ),
          );
        },
      );
      test(
        'When getQuckSearchData() should return QuckSearchResponseDTO',
        () async {
          when(
            mockedHttpClient.post(
              any,
              headers: anyNamed('headers'),
              body: jsonEncode(postRequest.toJson()),
            ),
          ).thenAnswer((_) async => httpQueryResponse);

          final postRespons =
              await dataSourcesImpl.getQuckSearchData(searchPattern);
          expect(postRespons, isA<QuickSearchResponseDto>());
        },
      );
      test(
        'When post() return exeption, getQuckSearchData should throw ServerExeption',
        () async {
          when(
            mockedHttpClient.post(
              any,
              // headers: anyNamed('headers'),
              // body: jsonEncode(postRequest.toJson()),
            ),
          ).thenAnswer((_) async => httpQueryResponseWithError);

          final call = dataSourcesImpl.getQuckSearchData;
          expect(
            () => call(searchPattern),
            throwsA(
              const TypeMatcher<ServerException>(),
            ),
          );
        },
      );
    },
  );
}
