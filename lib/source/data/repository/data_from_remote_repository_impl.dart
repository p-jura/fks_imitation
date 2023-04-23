import 'package:fuksiarz_imitation/core/errors/no_data_failure.dart';
import 'package:fuksiarz_imitation/core/errors/server_error.dart';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
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
    final remoteData = await _dataSource.getRemoteData(params);
    if (remoteData.code != null &&
        remoteData.code! >= 200 &&
        remoteData.code! < 300) {
      return Right(
        EventsDataList(
          eventDataModels: remoteData.data!,
        ),
      );
    }
    return Left(
      ServerError(
        errorCode: remoteData.code,
        message: remoteData.description,
      ),
    );
  }

  @override
  Future<Either<Failure, QuickSearchResponseList>>
      getQuickSearchDataFromeRemote(String? params) async {
    final response = await _dataSource.getQuckSearchData(params);
    
    return const Left(NoDataFoundFailure(message: 'no data found'));
  }
}
