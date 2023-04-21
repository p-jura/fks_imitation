import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/service/get_data.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class GetEventsDataFromRemote extends GetData<EventsDataList, NoParams> {
  final DataFromRemoteRepository repository;

  GetEventsDataFromRemote(this.repository);

  @override
  Future<Either<Failure, EventsDataList>> call([NoParams? params]) async {
    return await repository.getEventsDataFromRemote();
  }
  
}
