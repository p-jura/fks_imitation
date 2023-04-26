import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/errors/exceptions.dart';

import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class DataFromRemoteRepositoryImpl implements DataFromRemoteRepository {
  final RemoteDataSources _dataSource;

  DataFromRemoteRepositoryImpl({
    required RemoteDataSources dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Either<Failure, EventsDataList>> getEventsDataFromRemote([
    int? params,
  ]) async {
    try {
      final remoteData = await _dataSource.getRemoteData(params);
      if (remoteData.code == 200 && remoteData.data != null && remoteData.data!.isNotEmpty)  {
        return Right(
          EventsDataList(
            eventData: remoteData.data!,
          ),
        );
      } else {
        return const Left(
          NoDataFoundFailure(
            message: 'No data found',
          ),
        );
      }
    } on ServerException catch (exception) {
      return Left(
        ServerOrClientError(
          errorCode: exception.code,
          message: exception.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, QuickSearchResponseList>>
      getQuickSearchDataFromeRemote(String params) async {
    try {
      final quckSearchData = await _dataSource.getQuckSearchData(params);
      if (quckSearchData.code == 200 && quckSearchData.data != null) {
        return Right(
          QuickSearchResponseList(
            quickSearchResponse: quckSearchData.data!,
          ),
        );
      } else {
        return const Left(
          NoDataFoundFailure(
            message: 'No data found',
          ),
        );
      }
    } on ServerException catch (exception) {
      return Left(
        ServerOrClientError(
          errorCode: exception.code,
          message: exception.message,
        ),
      );
    }
  }
}
