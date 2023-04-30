import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';

import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/cubit/single_category_event_cubit.dart';

import 'package:mockito/mockito.dart';

import '../../../fixtures/remote_data_fixtures/event_data_fixture.dart';
import './events_data_bloc_test.mocks.dart';

void main() {
  late GetEventsDataFromRemote mockGetEvent;
  late SingleCategoryEventCubit tCubit;

  final EventData eventData = eventDataFixture;
  const int tCat = 5;

  setUp(() {
    mockGetEvent = MockGetEventsDataFromRemote();
    tCubit = SingleCategoryEventCubit(getEventsData: mockGetEvent);
  });
  blocTest(
    'LoadingState - should retrive data from remote server and emit LoadedState',
    build: () => tCubit,
    setUp: () {
      when(mockGetEvent.call(any)).thenAnswer(
        (_) async => Right(
          EventsDataList(eventData: [eventData]),
        ),
      );
    },
    act: (cubit) => cubit.getData(
      tCat,
    ),
    expect: () => [
      const SingleCategoryLoadingState(),
      SingleCategoryEventsLoadedState(
        categoryId: 1,
        eventsDataList: EventsDataList(
          eventData: [eventData],
        ),
      ),
    ],
  );
  blocTest(
    'Should emit state SingleCategoryLoadingState when response is failure',
    build: () => tCubit,
    setUp: () {
      when(mockGetEvent.call(any)).thenAnswer(
        (_) async => const Left(
          NoDataFoundFailure(message: 'test'),
        ),
      );
    },
    act: (cubit) => cubit.getData(tCat),
    expect: () => [
      const SingleCategoryLoadingState(),
    ],
  );
}
