import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:http/http.dart' as http;

class RemoteDataSourcesImpl implements RemoteDataSources {
  final http.Client _repository;

  RemoteDataSourcesImpl(http.Client repository) : _repository = repository;

  @override
  Future<EventsDataDto> getRemoteData() {
    // TODO: implement getListOfEventsData
    throw UnimplementedError();
  }
}
