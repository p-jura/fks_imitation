import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import '../../fixtures/fixture_reader.dart';

void main() {
  final String outcomeFixture = readFixture('outcome_fixture.json');
  final String eventGamesFixture = readFixture('event_games_fixture.json');
  final String eventDataFixture = readFixture('event_data_fixture.json');
  final String remoteDataFixture = readFixture('remote_data_fixture.json');
  const OutcomeData outcomeData = OutcomeData(
    outcomeId: 1,
    outcomeName: null,
    outcomeOdds: 1.0,
    status: 100,
  );

  const eventGame = Event(
    gameId: 1,
    gameName: 'int',
    gameType: 1,
    gameCode: 1,
    argument: 1.0,
    combinationType: 1,
    marketTypes: [],
    gameLayout: 1,
    eventLayout: 1,
    outcome: [outcomeData],
  );

  final Data mockedDataModel = Data(
    eventId: 1,
    eventName: 'string',
    category1Id: 1,
    category2Id: 1,
    category3Id: 1,
    category1Name: 'string',
    category2Name: 'string',
    category3Name: 'string',
    eventCodeId: 1,
    dataEventStarts: DateTime.fromMillisecondsSinceEpoch(1681981200000),
    eventType: 1,
    gamesCount: 1,
    remoteId: 1,
    eventExtendedData: const {
      'neutralGround': 'string',
      'remoteCategoryId': 'string',
    },
    dataEventGames: const [eventGame],
  );

  test('OutcomeData fromJson', () {
    final json = jsonDecode(outcomeFixture);

    final result = OutcomeData.fromJson(json);

    expect(
      result,
      equals(outcomeData),
    );
  });

  test(
    'Event fromJson',
    () {
      final json = jsonDecode(eventGamesFixture);

      final result = Event.fromJson(json);

      expect(
        result,
        equals(eventGame),
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
