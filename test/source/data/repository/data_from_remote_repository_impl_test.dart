import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:fuksiarz_imitation/source/data/repository/data_from_remote_repository_impl.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/event_data_fixture.dart';
@GenerateNiceMocks([MockSpec<RemoteDataSources>()])
import './data_from_remote_repository_impl_test.mocks.dart';

void main() {
  late RemoteDataSources mockDataSource;
  late DataFromRemoteRepositoryImpl repository;
  final mockedDTO = EventsDataDto(
    code: 200,
    discription: 'discription',
    data: [
      dataFixture,
    ],
  );
  final List<EventData> mockDataList = [dataFixture];
  final mockedEventDataList = EventsDataList(eventDataModels: mockDataList);

  const mockedDTOwithoutData =
      EventsDataDto(code: 400, discription: 'discription', data: null);

  setUp(
    () {
      mockDataSource = MockRemoteDataSources();
      repository = DataFromRemoteRepositoryImpl(dataSource: mockDataSource);
    },
  );
  test(
    'Should return Right(List<EventsDataList>) when the getListOfEvent() is called',
    () async {
      when(mockDataSource.getRemoteData())
          .thenAnswer((_) async => mockedDTO);

      final result = await repository.getEventsDataFromRemote();

      verify(mockDataSource.getRemoteData());
      expect(
        result,
        equals(
          Right(mockedEventDataList),
        ),
      );
    },
  );
  test(
    'Should return ServerError when the getListOfEvent() is called',
    () async {
      when(mockDataSource.getRemoteData())
          .thenAnswer((_) async => mockedDTOwithoutData);

      final result = await repository.getEventsDataFromRemote();

      expect(
        result.isLeft(),
        equals(true),
      );
    },
  );
}
