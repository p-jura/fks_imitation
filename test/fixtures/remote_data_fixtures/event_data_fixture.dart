import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';

final EventData eventDataFixture = EventData(
    eventId: 1,
    eventName: 'eventName',
    category1Id: 1,
    category2Id: 2,
    category3Id: 3,
    category1Name: 'category1Name',
    category2Name: 'category2Name',
    category3Name: 'category3Name',
    eventCodeId: 1,
    eventStart: DateTime.now(),
    eventType: 1,
    gamesCount: 1,
    remoteId: 1,
    eventExtendedData: const {},
    eventGames: const [],
  );

  final Data dataFixture = Data(
    eventId: 1,
    eventName: 'eventName',
    category1Id: 1,
    category2Id: 2,
    category3Id: 3,
    category1Name: 'category1Name',
    category2Name: 'category2Name',
    category3Name: 'category3Name',
    eventCodeId: 1,
    dataEventStarts: DateTime.now(),
    eventType: 1,
    gamesCount: 1,
    remoteId: 1,
    eventExtendedData: const {},
    dataEventGames: const [],
  );