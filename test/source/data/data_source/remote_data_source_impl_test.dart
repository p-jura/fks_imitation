import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source_impl.dart';
import '../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import './remote_data_source_impl_test.mocks.dart';

void main() {
  late MockClient mockedHttpClient;
  late RemoteDataSourcesImpl dataSourcesImpl;

  final mockedDTO = readFixture('outcome_fixture.json');
  final http.Response httpResponse = http.Response(mockedDTO, 200);
  final url =
      Uri.parse('https://fuksiarz.pl/rest/market/categories/multi/13/events');
  setUp(
    () {
      mockedHttpClient = MockClient();
      dataSourcesImpl = RemoteDataSourcesImpl(mockedHttpClient);
    },
  );
  test(
    'when getRemoteData() is called should return DTO',
    () async {
      when(mockedHttpClient.get(any)).thenAnswer((_) async => httpResponse);

      final result = await dataSourcesImpl.getRemoteData();
      verify(
        mockedHttpClient.get(
          url,
          headers: {'Content-Type': 'application/json'},
        ),
      );
    },
  );
}
