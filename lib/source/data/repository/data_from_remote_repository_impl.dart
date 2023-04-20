
import 'package:fuksiarz_imitation/source/domain/entities.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class DataFromRemoteRepositoryImpl implements DataFromRemoteRepository{
  @override
  Future<Either<Failure, EventData>> getEventsDataFromRemote() {
    // TODO: implement getEventsDataFromRemote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EventData>> getQueryDataFromRemote(QuickSearchBody query) {
    // TODO: implement getQueryDataFromRemote
    throw UnimplementedError();
  }
  
}