
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class DataFromRemoteRepositoryImpl implements DataFromRemoteRepository{
  @override
  Future<Either<Failure, EventsDataList>> getEventsDataFromRemote() {
    // TODO: implement getEventsDataFromRemote
    throw UnimplementedError();
  }  
}