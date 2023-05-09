import 'package:dartz/dartz.dart';

import 'package:fuksiarz_imitation/core/errors/exceptions.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/core/service/cache_status.dart';
import 'package:fuksiarz_imitation/source/data/data_source/cache_life_cicle.dart';
import 'package:fuksiarz_imitation/source/data/data_source/local_data_source.dart';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_repository.dart';

class DataRepositoryImpl implements DataRepository {
  final RemoteDataSources _remoteDataSource;
  final LocalDataSource _localDataSource;
  final CacheStatus _cacheStatus;
  final CacheLifeCicle _cacheLifeCicle;
  DataRepositoryImpl({
    required RemoteDataSources remoteDataSources,
    required LocalDataSource localDataSource,
    required CacheStatus cacheStatus,
    required CacheLifeCicle cacheLifeCicle,
  })  : _remoteDataSource = remoteDataSources,
        _localDataSource = localDataSource,
        _cacheStatus = cacheStatus,
        _cacheLifeCicle = cacheLifeCicle;

  @override
  Future<Either<Failure, EventsDataList>> getEventsDataFromRemote([
    int? params,
  ]) async {
    final cacheStatus = await _cacheStatus.isDataStored(params);
    final shouldOverrideData = await _cacheLifeCicle.shouldOverrideData(params);
    if (!cacheStatus || shouldOverrideData) {
      try {
        final remoteData = await _remoteDataSource.getRemoteData(params);
        if (remoteData.code == 200 &&
            remoteData.data != null &&
            remoteData.data!.isNotEmpty) {
          _localDataSource.cashData(
            data: remoteData,
            params: params,
          );
          return Right(
            EventsDataList(
              eventData: remoteData.data!,
            ),
          );
        } else {
          return const Left(
            NoDataFoundFailure(
              message: constants.NO_DATA_FOUND_FAILURE_MESSAGE,
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
    } else {
      return getEventsDataFromLocal(params);
    }
  }

  @override
  Future<Either<Failure, QuickSearchResponseList>>
      getQuickSearchDataFromeRemote(String params) async {
    try {
      final quckSearchData = await _remoteDataSource.getQuckSearchData(params);
      if (quckSearchData.code == 200 && quckSearchData.data != null) {
        return Right(
          QuickSearchResponseList(
            quickSearchResponse: quckSearchData.data!,
          ),
        );
      } else if (quckSearchData.code == 200 && quckSearchData.data == null) {
        return const Left(
          NoDataFoundFailure(
            message: constants.NO_DATA_FOUND_FAILURE_MESSAGE,
          ),
        );
      } else {
        throw ServerException(quckSearchData.code, quckSearchData.description);
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
  Future<Either<Failure, EventsDataList>> getEventsDataFromLocal([
    int? params,
  ]) async {
    try {
      final cacheStatus = await _cacheStatus.isDataStored(params);
      final shouldOverrideData =
          await _cacheLifeCicle.shouldOverrideData(params);
      if (cacheStatus && !shouldOverrideData) {
        final localData = await _localDataSource.getLocalData(params);

        if (localData.data!.isNotEmpty) {
          return Right(EventsDataList(eventData: localData.data!));
        } else {
          return const Left(
            NoDataFoundFailure(
              message: constants.NO_DATA_FOUND_FAILURE_CACHE_MESSAGE,
            ),
          );
        }
      } else {
        await _cacheLifeCicle.clearCache(params.toString());
        return getEventsDataFromRemote(params);
      }
    } on NoDataCached catch (failure) {
      return Left(NoDataCached(failure.message));
    }
  }
}
