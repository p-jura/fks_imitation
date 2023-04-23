import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/core/errors/no_data_failure.dart';
import 'package:fuksiarz_imitation/core/errors/server_error.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:fuksiarz_imitation/source/data/repository/data_from_remote_repository_impl.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import '../../../fixtures/quick_search_fixtures/quick_serach_response_dto_fixture.dart';
import '../../../fixtures/remote_data_fixtures/event_data_fixture.dart';
@GenerateNiceMocks([MockSpec<RemoteDataSources>()])
import './data_from_remote_repository_impl_test.mocks.dart';

void main() {
  late RemoteDataSources mockDataSource;
  late DataFromRemoteRepositoryImpl tRepository;
  setUp(
    () {
      mockDataSource = MockRemoteDataSources();
      tRepository = DataFromRemoteRepositoryImpl(dataSource: mockDataSource);
    },
  );
  group(
    'RemoteDataSources',
    () {
      final mockedDTO = EventsDataDto(
        code: 200,
        description: 'discription',
        data: [
          dataFixture,
        ],
      );
      final List<EventData> mockDataList = [dataFixture];
      final mockedEventDataList = EventsDataList(eventDataModels: mockDataList);
      const mockedDTOwithoutData =
          EventsDataDto(code: 400, description: 'discription', data: null);

      test(
        'Should return Right(EventsDataList) when the getListOfEvent() is called',
        () async {
          when(mockDataSource.getRemoteData(any))
              .thenAnswer((_) async => mockedDTO);

          final result = await tRepository.getEventsDataFromRemote();

          verify(mockDataSource.getRemoteData(null));
          expect(
            result,
            equals(
              Right(mockedEventDataList),
            ),
          );
        },
      );
      test(
        'Should return ServerError when the getListOfEvent() is called without data',
        () async {
          when(mockDataSource.getRemoteData(any))
              .thenAnswer((_) async => mockedDTOwithoutData);

          final result = await tRepository.getEventsDataFromRemote(1);

          expect(
            result.isLeft(),
            equals(true),
          );
        },
      );
    },
  );
  group('QuickSearchDataSource', () {
    const String tStr = 'test';
    const QuickSearchResponseData quickSearchDtoFixture =
        quickSearchResposnseDTO;
    const NoDataFoundFailure tfailure =
        NoDataFoundFailure(message: 'no data found');
    test('Should return failure when quick search is called with no data',
        () async {
      when(mockDataSource.getQuckSearchData(any))
          .thenAnswer((_) async => quickSearchDtoFixture);

      final result = await tRepository.getQuickSearchDataFromeRemote(tStr);
      expect(result, isA<Left>());
      expect(result, equals(const Left(tfailure)));
    });
    test('Should return failure server error when quick search is called ',
        () async {
      when(mockDataSource.getQuckSearchData(any))
          .thenAnswer((_) async => quickSearchDtoFixture);

      final result = await tRepository.getQuickSearchDataFromeRemote(tStr);

      expect(result.fold((l) => l, (r) => null), isA<ServerError>());
    });
  });
}
