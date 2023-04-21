import 'package:fuksiarz_imitation/core/errors/server_error.dart';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class DataFromRemoteRepositoryImpl implements DataFromRemoteRepository {
  final RemoteDataSources dataSource;

  DataFromRemoteRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, EventsDataList>> getEventsDataFromRemote() async {
    final remoteData = await dataSource.getRemoteData();
    if (remoteData.code != null &&
        remoteData.code! >= 200 &&
        remoteData.code! < 300) {
      return Right(
        EventsDataList(
          eventDataModels: remoteData.data!,
        ),
      );
    }
    return Left(
      ServerError(
        errorCode: remoteData.code,
        message: remoteData.discription,
      ),
    );
  }
}
