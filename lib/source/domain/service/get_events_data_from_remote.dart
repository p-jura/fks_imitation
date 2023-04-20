import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/service/get_data.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class GetEventsDataFromRemote implements GetData{
  final DataFromRemoteRepository repository;

  GetEventsDataFromRemote(this.repository);

  @override
  Future<Either<Failure, dynamic>> call() {
   return repository.getEventsDataFromRemote();
  }
  

}