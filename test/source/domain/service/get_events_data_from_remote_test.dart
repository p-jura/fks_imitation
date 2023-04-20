import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

@GenerateNiceMocks(
  [
    MockSpec<DataFromRemoteRepository>(),
    MockSpec<Failure>(),
  ],
)
import './get_events_data_from_remote_test.mocks.dart';

void main() {
  late DataFromRemoteRepository mockedRepository;
  late GetEventsDataFromRemote tEvent;
  final EventData eventData = EventData(
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
    eventExtendedData: const [],
    eventGames: const [],
  );
  late Failure mFailure;
  setUp(() {
    mockedRepository = MockDataFromRemoteRepository();
    tEvent = GetEventsDataFromRemote(mockedRepository);
    mFailure = MockFailure();
  });
  test(
    'Should return EventData when remote is called',
    () async {
      when(
        mockedRepository.getEventsDataFromRemote(),
      ).thenAnswer(
        (_) async => Right(eventData),
      );

      final resoult = await tEvent.call();

      expect(
        resoult,
        Right(eventData),
      );
      verify(mockedRepository.getEventsDataFromRemote());
      verifyNoMoreInteractions(mockedRepository);
    },
  );
  test(
    'Should return Failure when remote is called',
    () async {
      when(
        mockedRepository.getEventsDataFromRemote(),
      ).thenAnswer(
        (_) async => Left(mFailure),
      );

      final resoult = await tEvent.call();

      expect(
        resoult,
        Left(mFailure),
      );
      verify(mockedRepository.getEventsDataFromRemote());
      verifyNoMoreInteractions(mockedRepository);
    },
  );
}
