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

import '../../../fixtures/quick_search_fixtures/quick_search_response_fixture.dart';
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
  const String tString = 'test';
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

  group('_getAllCategoriesEventData()', () {
    final EventData eventData = eventDataFixture;
    final List<Map<String, dynamic>> mapOfCatWithEventFixture = [
      {
        'categoryName': 'WSZYSTKO',
        'categoryEventsCount': 2,
        'isActive': true,
      },
      mapOfCatWithEventCountFixture,
      mapOfCatWithEventCountFixture
    ];
    blocTest(
      'Should emit state with data from all categories',
      build: () => tBloc,
      setUp: () => when(mockGetEvent.call(any)).thenAnswer(
        (_) async => Right(
          EventsDataList(eventData: [eventData]),
        ),
      ),
      act: (bloc) => bloc.add(GetEventsFromRemoteAllCategories(2)),
      expect: () => [
        LoadingState(),
        AllCategoriesEventsLoadedState(
          allEventsDataList: [
            EventsDataList(eventData: [eventData]),
            EventsDataList(eventData: [eventData]),
          ],
          categoriesWithEvents: mapOfCatWithEventFixture,
        ),
      ],
    );
  });
  group('_getQueryData()', () {
    const QuickSearchResponse tQuickSearchResponse =
        quickSearchResponseDataFixture;
    const QuickSearchResponseList tQsearchList = QuickSearchResponseList(
      quickSearchResponse: [
        tQuickSearchResponse,
      ],
    );
    blocTest(
      'should emit state QueryLoadedState() when data is properly retrived',
      build: () => tBloc,
      setUp: () {
        when(mockGetQuickSearch.call(tString)).thenAnswer(
          (_) async => const Right(
            tQsearchList,
          ),
        );
      },
      act: (bloc) => bloc.add(
        GetQueryFromRemote(
          query: tString,
        ),
      ),
      expect: () =>
          [LoadingState(), QueryLoadedState(qickSearchEventList: tQsearchList)],
    );
  });
  List<EventData> tList = const [
    EventData(
      eventId: 1,
      eventName: 'eventName',
      category1Id: 1,
      category2Id: 2,
      category3Id: 3,
      category1Name: 'category1Name',
      category2Name: 'category2Name',
      category3Name: 'category3Name',
      eventCodeId: 1,
      eventStart: null,
      eventType: null,
      gamesCount: 1,
      remoteId: null,
      eventExtendedData: null,
      eventGames: [],
    ),
    EventData(
      eventId: 1,
      eventName: 'eventName',
      category1Id: 1,
      category2Id: 2,
      category3Id: 3,
      category1Name: 'category1Name',
      category2Name: 'category2Name',
      category3Name: 'category3Name',
      eventCodeId: 1,
      eventStart: null,
      eventType: null,
      gamesCount: 4,
      remoteId: null,
      eventExtendedData: null,
      eventGames: [],
    )
  ];
}
