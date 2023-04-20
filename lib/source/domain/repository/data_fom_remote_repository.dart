import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities.dart';

abstract class DataFromRemoteRepository {
  Future<Either<Failure, EventData>> getEventsDataFromRemote();
  Future<Either<Failure, EventData>> getQueryDataFromRemote(
      QuickSearchBody query,);
}
