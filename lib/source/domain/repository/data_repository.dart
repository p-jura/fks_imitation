import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';

abstract class DataRepository {
  Future<Either<Failure, EventsDataList>> getEventsDataFromRemote([
    int? params,
  ]);
  Future<Either<Failure, QuickSearchResponseList>>
      getQuickSearchDataFromeRemote(String params);
  Future<Either<Failure, EventsDataList>> getEventsDataFromLocal([int? params]);
}
