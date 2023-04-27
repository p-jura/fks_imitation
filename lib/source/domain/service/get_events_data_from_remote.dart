import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/service/get_data.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class GetEventsDataFromRemote extends GetData<EventsDataList, int> {
  final DataFromRemoteRepository _repository;

  GetEventsDataFromRemote(DataFromRemoteRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failure, EventsDataList>> call([int? params]) async {
    
    return await _repository.getEventsDataFromRemote(params);
  }
}
