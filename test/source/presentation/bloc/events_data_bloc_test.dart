import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/remote_data_fixtures/event_data_fixture.dart';
@GenerateNiceMocks([
  MockSpec<GetEventsDataFromRemote>(),
  MockSpec<GetQuickSearchDataFromeRemote>()
])
import './events_data_bloc_test.mocks.dart';

void main() {
  late GetEventsDataFromRemote mockGetEvent;
  late GetQuickSearchDataFromeRemote mockGetQuickSearch;
  late EventsDataBloc tBloc;
  const int tCat = 1;
  setUp(() {
    mockGetEvent = MockGetEventsDataFromRemote();
    mockGetQuickSearch = MockGetQuickSearchDataFromeRemote();
    tBloc = EventsDataBloc(
      getEventsData: mockGetEvent,
      getQuickSearchData: mockGetQuickSearch,
    );
  });
  blocTest(
    'Initial state should be EmptyState()',
    build: () => tBloc,
    verify: (bloc) => expect(
      bloc.state,
      isA<EmptyState>(),
    ),
  );
  final EventData eventData = eventDataFixture;
  blocTest(
    'LoadingState should retrive getEventsDataFromRemote() and emit LoadedState',
    build: () => tBloc,
    setUp: () {
      when(mockGetEvent.call(any)).thenAnswer(
        (_) async => Right(
          EventsDataList(eventDataModels: [eventData]),
        ),
      );
    },
    act: (bloc) => bloc.add(
      GetEventsFromRemote(tCat),
    ),
    expect: () => [
      LoadingState(),
      LoadedState(
        eventsDataList: EventsDataList(
          eventDataModels: [eventData],
        ),
      ),
    ],
  );
  // blocTest('', build: build)
}
