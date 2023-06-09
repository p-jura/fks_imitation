import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:fuksiarz_imitation/source/domain/repository/data_repository.dart';

import '../../../fixtures/remote_data_fixtures/event_data_fixture.dart';
@GenerateNiceMocks(
  [
    MockSpec<DataRepository>(),
    MockSpec<Failure>(),
  ],
)
import './get_events_data_from_remote_test.mocks.dart';

void main() {
  late DataRepository mockedRepository;
  late GetEventsDataFromRemote tEvent;
  late Failure mFailure;
  final EventsDataList listOfEventsFixture =
      EventsDataList(eventData: [eventDataFixture]);

  setUp(() {
    mockedRepository = MockDataRepository();
    tEvent = GetEventsDataFromRemote(mockedRepository);
    mFailure = MockFailure();
  });
  test(
    'Should return EventDataList when remote is called',
    () async {
      when(
        mockedRepository.getEventsDataFromRemote(),
      ).thenAnswer((_) async => Right(listOfEventsFixture));

      final resoult = await tEvent.call();

      expect(
        resoult,
        Right(listOfEventsFixture),
      );
      verify(mockedRepository.getEventsDataFromRemote());
      verifyNoMoreInteractions(mockedRepository);
    },
  );
  test(
    'Should return Failure when remote is called without data',
    () async {
      when(
        mockedRepository.getEventsDataFromRemote(),
      ).thenAnswer((_) async => Left(mFailure));

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
