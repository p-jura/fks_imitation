import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
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
  const int tCat = 1;
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
  group(
    '_getData()',
    () {
      final EventData eventData = eventDataFixture;
      blocTest(
        'LoadingState - should retrive data from remote server and emit LoadedState',
        build: () => tBloc,
        setUp: () {
          when(mockGetEvent.call(any)).thenAnswer(
            (_) async => Right(
              EventsDataList(eventData: [eventData]),
            ),
          );
        },
        act: (bloc) => bloc.add(
          GetEventsFromRemoteSingleCategory(tCat),
        ),
        expect: () => [
          LoadingState(),
          SingleCategoryEventsLoadedState(
            eventsDataList: EventsDataList(
              eventData: [eventData],
            ),
          ),
        ],
      );
      blocTest(
        'Should emit state to Loaded with empty data list when response is failure',
        build: () => tBloc,
        setUp: () {
          when(mockGetEvent.call(any)).thenAnswer(
            (_) async => const Left(
              NoDataFoundFailure(message: 'test'),
            ),
          );
        },
        act: (bloc) => bloc.add(
          GetEventsFromRemoteSingleCategory(tCat),
        ),
        expect: () => [
          LoadingState(),
          SingleCategoryEventsLoadedState(
            eventsDataList: const EventsDataList(
              eventData: [],
            ),
          ),
        ],
      );
    },
  );
  group('_getAllCategoriesEventData()', () {
    final EventData eventData = eventDataFixture;
    final List<Map<String, dynamic>> mapOfCatWithEventFixture = [
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
          allCategoriesEventsList: [
            EventsDataList(eventData: [eventData]),
            EventsDataList(eventData: [eventData]),
          ],
          listOfMappedCatWithEventsCount: mapOfCatWithEventFixture,
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
    ),
  ];
  test('extension addAllElementsWitchFieldName extension', () {
    final resoult = tList.addAllGamesInList();
    expect(resoult, 13);
  });
}
