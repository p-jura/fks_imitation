import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';
import '../../../fixtures/quick_search_response_fixture.dart';
@GenerateNiceMocks(
  [
    MockSpec<DataFromRemoteRepository>(),
    MockSpec<Failure>(),
  ],
)
import './get_quick_searchdata_from_remote_test.mocks.dart';

void main() {
  late GetQuickSearchDataFromeRemote tSearch;
  late DataFromRemoteRepository mockedRepository;
  late Failure mFailure;
  const String tParams = 'any';
  const QuickSearchResponseList rFixture =
      QuickSearchResponseList([quickSearchResponseBody]);

  setUp(() {
    mockedRepository = MockDataFromRemoteRepository();
    tSearch = GetQuickSearchDataFromeRemote(mockedRepository);
    mFailure = MockFailure();
  });
  test('Should return failure when no data is in quick search ', () async {
    when(mockedRepository.getQuickSearchDataFromeRemote(any))
        .thenAnswer((_) async => Left(mFailure));
    
    final result = await tSearch.call(tParams);
    
    expect(result, isA<Left>());
  });
  test('Should return QickSearchResponseList when remote repo is called',
      () async {
    when(mockedRepository.getQuickSearchDataFromeRemote(any))
        .thenAnswer((_) async => const Right(rFixture));
   
    final result = await tSearch.call(tParams);
   
    expect(
      result,
      equals(const Right(rFixture)),
    );
  });
}
