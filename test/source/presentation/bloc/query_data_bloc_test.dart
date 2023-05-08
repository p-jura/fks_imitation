import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_cubit/query_data_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/quick_search_fixtures/quick_search_response_fixture.dart';

@GenerateNiceMocks([
  MockSpec<GetQuickSearchDataFromeRemote>(),
  MockSpec<GetEventsDataFromRemote>()
])
import './query_data_bloc_test.mocks.dart';

void main() {
  late MockGetQuickSearchDataFromeRemote mockGetQuickSearchDataFromeRemote;
  late MockGetEventsDataFromRemote mockGetEventsDataFromeRemote;
  late QueryDataCubit tQBloc;

  const String tString = 'string';

  setUp(() {
    mockGetQuickSearchDataFromeRemote = MockGetQuickSearchDataFromeRemote();
    mockGetEventsDataFromeRemote = MockGetEventsDataFromRemote();
    tQBloc = QueryDataCubit(
        getQuickSearchData: mockGetQuickSearchDataFromeRemote,
        getEventsDataFromRemote: mockGetEventsDataFromeRemote);
  });
  group('_getQueryData()', () {
    final QuickSearchResponse tQuickSearchResponse =
        quickSearchResponseDataFixture;
    final QuickSearchResponseList tQsearchList = QuickSearchResponseList(
      quickSearchResponse: [
        tQuickSearchResponse,
      ],
    );
    final EventsDataList tEventsDataList =
        EventsDataList(eventData: [qsEventDataFixture]);
    blocTest(
      'should emit state QueryLoadedState() when data is properly retrived',
      build: () => tQBloc,
      setUp: () {
        when(mockGetQuickSearchDataFromeRemote.call(any))
            .thenAnswer((_) async => Right(tQsearchList));
        when(mockGetEventsDataFromeRemote.call(any))
            .thenAnswer((_) async => Right(tEventsDataList));
      },
      act: (cubit) => cubit.getQueryData(tString),
      expect: () => [
        LoadingState(),
        QueryLoadedState(eventsDataList: tEventsDataList),
      ],
    );
  });
}
