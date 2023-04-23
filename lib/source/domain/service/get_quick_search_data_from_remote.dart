import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/service/get_data.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_fom_remote_repository.dart';

class GetQuickSearchDataFromeRemote
    implements GetData<QuickSearchResponseList, String> {
  final DataFromRemoteRepository _repository;

  GetQuickSearchDataFromeRemote(DataFromRemoteRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failure, QuickSearchResponseList>> call(String params) async {
   return _repository.getQuickSearchDataFromeRemote(params);
  }
}
