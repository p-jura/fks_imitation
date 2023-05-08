import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_cubit/query_data_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/quick_search_fixtures/quick_search_response_fixture.dart';

@GenerateNiceMocks([MockSpec<GetQuickSearchDataFromeRemote>()])
import './query_data_bloc_test.mocks.dart';

void main() {
  late GetQuickSearchDataFromeRemote mockGetQuickSearchDataFromeRemote;
  late QueryDataCubit tQBloc;

  const String tString = 'string';

  setUp(() {
    mockGetQuickSearchDataFromeRemote = MockGetQuickSearchDataFromeRemote();
    tQBloc =
        QueryDataCubit(getQuickSearchData: mockGetQuickSearchDataFromeRemote, getEventsDataFromRemote: null);
  });
  group('_getQueryData()', () {
    QuickSearchResponse tQuickSearchResponse = quickSearchResponseDataFixture;
    QuickSearchResponseList tQsearchList = QuickSearchResponseList(
      quickSearchResponse: [
        tQuickSearchResponse,
      ],
    );
    blocTest(
      'should emit state QueryLoadedState() when data is properly retrived',
      build: () => tQBloc,
      setUp: () {
        when(mockGetQuickSearchDataFromeRemote.call(tString)).thenAnswer(
          (_) async => Right(
            tQsearchList,
          ),
        );
      },
      act: (bloc) => bloc.getQueryData(
        tString,
      ),
      expect: () =>
          [LoadingState(), QueryLoadedState(qickSearchEventList: tQsearchList)],
    );
  });
}
