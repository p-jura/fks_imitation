import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/core/service/cache_status.dart';
import 'package:fuksiarz_imitation/source/data/data_source/local_data_source.dart';
import 'package:fuksiarz_imitation/source/data/repository/data_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fuksiarz_imitation/core/errors/exceptions.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';

import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import '../../../fixtures/quick_search_fixtures/quick_serach_response_dto_fixture.dart';
import '../../../fixtures/remote_data_fixtures/event_data_fixture.dart';
@GenerateNiceMocks([
  MockSpec<RemoteDataSources>(),
  MockSpec<LocalDataSource>(),
  MockSpec<CacheStatus>(),
])
import './data_repository_impl_test.mocks.dart';

void main() {
  late RemoteDataSources mockRemoteDataSource;
  late LocalDataSource mockLocalDataSource;
  late DataRepositoryImpl tRepository;
  late CacheStatus mockCacheStatus;
  setUp(
    () {
      mockCacheStatus = MockCacheStatus();

      when(mockCacheStatus.isDataSrored).thenAnswer((_) async => false);

      mockLocalDataSource = MockLocalDataSource();
      mockRemoteDataSource = MockRemoteDataSources();

      tRepository = DataRepositoryImpl(
        remoteDataSources: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        cacheStatus: mockCacheStatus,
      );
    },
  );
  group(
    'RemoteDataSources',
    () {
      setUp(() {
        when(mockCacheStatus.isDataSrored).thenAnswer((_) async => false);
      });
      final mockedDTO = EventsDataDto(
        code: 200,
        description: 'discription',
        data: [
          dataFixture,
        ],
      );
      final List<EventData> mockDataList = [dataFixture];
      final mockedEventDataList = EventsDataList(eventData: mockDataList);
      const mockedDTOwithoutData =
          EventsDataDto(code: 400, description: 'discription', data: null);

      test(
        'Should return Right(EventsDataList) when the getListOfEvent() is called',
        () async {
          when(mockRemoteDataSource.getRemoteData(any))
              .thenAnswer((_) async => mockedDTO);

          final result = await tRepository.getEventsDataFromRemote();

          verify(mockRemoteDataSource.getRemoteData(null));
          expect(
            result,
            equals(
              Right(mockedEventDataList),
            ),
          );
        },
      );
      test(
        'Should return NoDataFoundFailure when the getListOfEvent() is called without data',
        () async {
          when(mockRemoteDataSource.getRemoteData(any))
              .thenAnswer((_) async => mockedDTOwithoutData);

          final result = await tRepository.getEventsDataFromRemote(1);

          expect(
            result.isLeft(),
            equals(true),
          );
          expect(
            result.fold(
              (l) => l,
              (_) => null,
            ),
            isA<NoDataFoundFailure>(),
          );
        },
      );
      test(
        'Should return ServerOrClientError when the getListOfEvent() throws exception ',
        () async {
          when(mockRemoteDataSource.getRemoteData(any))
              .thenAnswer((_) async => throw ServerException());

          final result = await tRepository.getEventsDataFromRemote(1);

          expect(
            result.isLeft(),
            equals(true),
          );
          expect(
            result.fold(
              (l) => l,
              (_) => null,
            ),
            isA<ServerOrClientError>(),
          );
        },
      );
    },
  );
  group(
    'QuickSearchDataSource',
    () {
      setUp(() {
        when(mockCacheStatus.isDataSrored).thenAnswer((_) async => false);
      });
      const String tStr = 'test';
      test(
        'Should return failure when quick search is called with no data',
        () async {
          when(mockRemoteDataSource.getQuckSearchData(tStr))
              .thenAnswer((_) async => throw ServerException());

          final result = await tRepository.getQuickSearchDataFromeRemote(tStr);
          expect(
            result.fold(
              (l) => l,
              (_) => null,
            ),
            isA<ServerOrClientError>(),
          );
        },
      );
      test(
        'Should return failure server error when quick search is called ',
        () async {
          when(mockRemoteDataSource.getQuckSearchData(tStr))
              .thenAnswer((_) async => quickSearchResposnseDtoFixtureWithError);

          final result = await tRepository.getQuickSearchDataFromeRemote(tStr);

          expect(
            result.fold(
              (l) => l,
              (_) => null,
            ),
            isA<NoDataFoundFailure>(),
          );
        },
      );
      test(
        'Should return QuickSearchResponse when proper data is recived',
        () async {
          when(mockRemoteDataSource.getQuckSearchData(tStr))
              .thenAnswer((_) async => quickSearchResposnseDtoFixtures);

          final responseResult =
              await tRepository.getQuickSearchDataFromeRemote(tStr);
          final result = responseResult
              .fold(
                (_) => null,
                (r) => r,
              )!
              .quickSearchResponse;
          expect(
            result,
            quickSearchResposnseDtoFixtures.data,
          );
        },
      );
    },
  );
}
