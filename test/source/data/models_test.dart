import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:fuksiarz_imitation/source/domain/entities.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final String outcomeFixture = readFixture('outcome_fixture.json');
  final String eventGamesFixture = readFixture('event_games_fixture.json');
  final String eventDataFixture = readFixture('event_data_fixture.json');

  const outcome = Outcome(
    outcomeId: 1,
    outcomeName: null,
    outcomeOdds: 1.0,
    status: 100,
  );

  const eventGame = EventGame(
    gameId: 1,
    gameName: 'int',
    gameType: 1,
    gameCode: 1,
    argument: 1.0,
    combinationType: 1,
    marketTypes: [],
    gameLayout: 1,
    eventLayout: 1,
    outcomes: [outcome],
  );

  final EventDataModel mockedDataModel = EventDataModel(
    eventId: 1,
    eventName: 'string',
    category1Id: 1,
    category2Id: 1,
    category3Id: 1,
    category1Name: 'string',
    category2Name: 'string',
    category3Name: 'string',
    eventCodeId: 1,
    eventStart: DateTime.fromMillisecondsSinceEpoch(1681981200000),
    eventType: 1,
    gamesCount: 1,
    remoteId: 1,
    eventExtendedData: const [
      {
        'neutralGround': 'string',
        'remoteCategoryId': 'string',
      }
    ],
    eventGames: const [eventGame],
  );

  test(
    'OutcomesList.outcomesToList()',
    () {
      final jsonMap = jsonDecode(outcomeFixture);

      final List tOutcomeList = OutcomesList.outcomesToList(jsonMap).list;

      expect(
        tOutcomeList.first,
        equals(outcome),
      );
    },
  );

  test('EventGamesList.eventGamesToList()', () {
    // final List<Map<String, dynamic>> jsonMap =
    //     (jsonDecode(eventGamesFixture) as List)
    //         .map((e) => e as Map<String, dynamic>)
    //         .toList();
    final jsonMap = jsonDecode(eventGamesFixture);

    final List tEventGames = EventGamesList.eventGamesToList([jsonMap.first]).list;

    expect(
      tEventGames.first,
      equals(eventGame),
    );
  });
  test(
    'EventsDataList.fromJson()',
    () {
      final jsonMap = jsonDecode(eventDataFixture);

      final List tModelFromJson = EventsDataList.fromJson(jsonMap).list;

      expect(
        tModelFromJson.first,
        equals(mockedDataModel),
      );
    },
  );
  test(
    'EventsDataList.fromJson() should be equal to mockedList',
    () async {
      final jsonMap = jsonDecode(eventDataFixture);
      final EventsDataList mockedList =
          EventsDataList(eventDataModels: [mockedDataModel]);
      final tModelFromJson = EventsDataList.fromJson(jsonMap);

      expect(
        tModelFromJson,
        equals(mockedList),
      );
    },
  );
}
