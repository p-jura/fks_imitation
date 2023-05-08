import 'package:fuksiarz_imitation/source/domain/single_entities.dart';

final QuickSearchResponse quickSearchResponseDataFixture = QuickSearchResponse(
  area: 'LIVE_EVENT',
  name: 'qsRespName',
  id: 100,
  score: 1.0,
  eventStart: DateTime.fromMillisecondsSinceEpoch(1683383400000),
  // ignore: prefer_const_literals_to_create_immutables
  extras:  {},
);

final EventData qsEventDataFixture = EventData(
    eventId: 100,
    eventName: 'qsRespName',
    category1Id: 1,
    category2Id: 2,
    category3Id: 3,
    category1Name: 'category1Name',
    category2Name: 'category2Name',
    category3Name: 'category3Name',
    eventCodeId: null,
    eventStart: DateTime.fromMillisecondsSinceEpoch(1683383400000),
    eventType: 1,
    gamesCount: 1,
    remoteId: null,
    eventExtendedData: null,
    // ignore: prefer_const_literals_to_create_immutables
    eventGames: []);
