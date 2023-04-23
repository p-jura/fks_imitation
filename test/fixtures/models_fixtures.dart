  import 'package:fuksiarz_imitation/source/data/models.dart';

const OutcomeData outcomeDataFixture = OutcomeData(
    outcomeId: 1,
    outcomeName: null,
    outcomeOdds: 1.0,
    status: 100,
  );

  const eventGameFixture = Event(
    gameId: 1,
    gameName: 'int',
    gameType: 1,
    gameCode: 1,
    argument: 1.0,
    combinationType: 1,
    marketTypes: [],
    gameLayout: 1,
    eventLayout: 1,
    outcome: [outcomeDataFixture],
  );

  final Data dataModelFixture = Data(
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
    dataEventGames: const [eventGameFixture],
  );