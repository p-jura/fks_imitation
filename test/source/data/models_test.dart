import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import '../../fixtures/fixture_reader.dart';
import '../../fixtures/models_fixtures.dart';

void main() {
  final String outcomeFixture = readFixture('outcome_fixture.json', 'remote_data_fixtures');
  final String eventGamesFixture = readFixture('event_games_fixture.json', 'remote_data_fixtures');
  final String eventDataFixture = readFixture('event_data_fixture.json', 'remote_data_fixtures');
  final String remoteDataFixture = readFixture('remote_data_fixture.json', 'remote_data_fixtures');
  
  const OutcomeData mockedOutcomeData = outcomeDataFixture;
  const Event mockedEventGame = eventGameFixture;
  final Data mockedDataModel = dataModelFixture;

  test('OutcomeData fromJson', () {
    final json = jsonDecode(outcomeFixture);

    final result = OutcomeData.fromJson(json);

    expect(
      result,
      equals(mockedOutcomeData),
    );
  });

  test(
    'Event fromJson',
    () {
      final json = jsonDecode(eventGamesFixture);

      final result = Event.fromJson(json);

      expect(
        result,
        equals(mockedEventGame),
      );
    },
  );
  test(
    'Data fromJson',
    () {
      final json = jsonDecode(eventDataFixture);

      final result = Data.fromJson(json);

      expect(
        result,
        equals(mockedDataModel),
      );
    },
  );

  // this test is just to be sure that every nestet layers are in DTO
  // the json file is real response from server copied to fixtures
  test(
      'EventDataDto fromJson should return code 200 from remote_data_fixture.json file ',
      () {
    final json = jsonDecode(remoteDataFixture);

    final result = EventsDataDto.fromJson(json);
    expect(
      result.code,
      equals(
        200,
      ),
    );
  });
}
