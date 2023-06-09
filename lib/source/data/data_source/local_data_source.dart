import 'package:fuksiarz_imitation/source/data/models.dart';

abstract class LocalDataSource {
  Future<EventsDataDto> getLocalData([int? params]);
  Future<bool> cashData({required EventsDataDto data, int? params});
}
