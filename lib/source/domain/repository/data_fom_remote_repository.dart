import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/core/service/get_data.dart';
import 'package:fuksiarz_imitation/source/domain/entities.dart';

abstract class DataFromRemoteRepository implements GetData {
  Future<Either<Failure, EventData>> getEventsDataFromRemote();
  
}
