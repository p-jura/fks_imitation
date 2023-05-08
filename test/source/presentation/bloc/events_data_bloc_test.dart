import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit_cubit.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<GetEventsDataFromRemote>(),
  MockSpec<GetQuickSearchDataFromeRemote>()
])
import './events_data_bloc_test.mocks.dart';

void main() {
  late GetEventsDataFromRemote mockGetEvent;
  late AllCategoriesEventsCubit tCubit;
  setUp(() {
    mockGetEvent = MockGetEventsDataFromRemote();
    tCubit = AllCategoriesEventsCubit(
      getEventsData: mockGetEvent,
    );
  });

  blocTest(
    'Initial state should be EmptyState()',
    build: () => tCubit,
    verify: (bloc) => expect(
      bloc.state,
      isA<AllCategoriesEventsInitial>(),
    ),
  );

  group('_getAllCategoriesEventData()', () {
    const EventData eventData = EventData(
      eventId: 1,
      eventName: null,
      category1Id: 1,
      category2Id: 2,
      category3Id: 3,
      category1Name: 'String',
      category2Name: null,
      category3Name: null,
      eventCodeId: null,
      eventStart: null,
      eventType: null,
      gamesCount: 1,
      remoteId: null,
      eventExtendedData: null,
      eventGames: [],
    );
    final Map<int, Map<String, dynamic>> mapOfCatWithEventFixture = {
      0: {
        'categoryName': 'WSZYSTKO',
        'categoryEventsCount': 7,
        'isActive': true,
      },
      1: {
        'categoryName': 'STRING',
        'categoryEventsCount': 1,
      },
      2: {
        'categoryName': 'STRING',
        'categoryEventsCount': 1,
      },
      3: {
        'categoryName': 'STRING',
        'categoryEventsCount': 1,
      },
      4: {
        'categoryName': 'STRING',
        'categoryEventsCount': 1,
      },
      5: {
        'categoryName': 'STRING',
        'categoryEventsCount': 1,
      },
      6: {
        'categoryName': 'STRING',
        'categoryEventsCount': 1,
      },
      10: {
        'categoryName': 'STRING',
        'categoryEventsCount': 1,
      },
    };
    blocTest(
      'Should emit state with data from all categories',
      build: () => tCubit,
      setUp: () => when(mockGetEvent.call(any)).thenAnswer(
        (_) async => const Right(
          EventsDataList(eventData: [eventData]),
        ),
      ),
      act: (bloc) => bloc.getAllCategoriesEventData(),
      expect: () => [
        AllCategoriesEventsLoading(),
        AllCategoriesEventsLoadedState(
          categoriesWithEvents: mapOfCatWithEventFixture,
        ),
      ],
    );
  });

}
