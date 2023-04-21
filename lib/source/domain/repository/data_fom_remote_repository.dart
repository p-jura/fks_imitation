import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';


abstract class DataFromRemoteRepository {
  Future<Either<Failure, EventsDataList>> getEventsDataFromRemote();
}
