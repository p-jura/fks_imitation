import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_local.dart';
import '../../../fixtures/remote_data_fixtures/event_data_fixture.dart';
@GenerateNiceMocks(
  [
    MockSpec<DataRepository>(
      as: Symbol(
        'MockDataFromLocalRepo',
      ),
    ),
  ],
)
import './get_events_data_from_local_test.mocks.dart';
import './get_events_data_from_remote_test.mocks.dart';

void main() {
  late MockDataFromLocalRepo mockRepository;
  late GetEventsDataFromLocal tEvent;
  late MockFailure mFailure;

  final EventsDataList listOfEventsFixture =
      EventsDataList(eventData: [eventDataFixture]);

  const int tParam = 1;

  setUp(() {
    mockRepository = MockDataFromLocalRepo();
    tEvent = GetEventsDataFromLocal(mockRepository);
    mFailure = MockFailure();
  });

  test(
    'Should return EventDataList after calling local repo',
    () async {
      when(mockRepository.getEventsDataFromLocal(any))
          .thenAnswer((_) async => Right(listOfEventsFixture));

      final result = await tEvent.call(tParam);

      verify(mockRepository.getEventsDataFromLocal(any));
      expect(
        result,
        equals(
          Right(listOfEventsFixture),
        ),
      );
    },
  );
  test(
    'Should return Failure when local is called with some error',
    () async {
      when(
        mockRepository.getEventsDataFromLocal(any),
      ).thenAnswer((_) async => Left(mFailure));

      final resoult = await tEvent.call();

      expect(
        resoult,
        Left(mFailure),
      );
      verify(mockRepository.getEventsDataFromLocal(any));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
