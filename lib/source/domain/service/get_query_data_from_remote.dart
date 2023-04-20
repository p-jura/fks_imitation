import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/service/get_data.dart';
import 'package:fuksiarz_imitation/source/domain/entities.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class GetQueryDataFromRemote extends GetData<EventData, QuickSearchBody> {
  final DataFromRemoteRepository remoteRepository;

  GetQueryDataFromRemote(this.remoteRepository);
  @override
  Future<Either<Failure, EventData>> call(QuickSearchBody? params) async {
    return await remoteRepository.getQueryDataFromRemote(params!);
  }
}
