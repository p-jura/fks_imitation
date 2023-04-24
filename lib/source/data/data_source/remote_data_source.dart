import 'package:fuksiarz_imitation/source/data/models.dart';

abstract class RemoteDataSources {

  /// Use param to set category id URL. 
  Future<EventsDataDto> getRemoteData([int? params]);
  Future<QuickSearchResponseDto> getQuckSearchData(String params);
}
