
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
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

  final dtoStingFixture = readFixture('remote_data_simple_fixture.json');
  const mockDto =
      EventsDataDto(code: 200, description: 'OK.', data: []);
  final http.Response httpResponse = http.Response(dtoStingFixture, 200);

  const int tCat = 1;
  final url = Uri.parse(
    'https://fuksiarz.pl/rest/market/categories/multi/$tCat/events',
  );
  setUp(
    () {
      mockedHttpClient = MockClient();
      dataSourcesImpl = RemoteDataSourcesImpl(mockedHttpClient);
    },
  );
  test(
    'veryfieing proper category is selected',
    () async {
      await dataSourcesImpl.getRemoteData(tCat);
      verify(
        mockedHttpClient.get(
          url,
          headers: {'Content-Type': 'application/json'},
        ),
      );
    },
  );
  test('when getRemoteData() is called should return DTO', () async {
    when(
      mockedHttpClient.get(
        any,
        headers: {'Content-Type': 'application/json'},
      ),
    ).thenAnswer((_) async => httpResponse);
    final response = await dataSourcesImpl.getRemoteData(tCat);
    expect(response.code, 200);
    expect(
      response,
      equals(mockDto),
    );
    expect(
      response.runtimeType,
      equals(EventsDataDto),
    );
  });
}
