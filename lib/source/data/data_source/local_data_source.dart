import 'package:fuksiarz_imitation/source/data/models.dart';

abstract class LocalDataSource {
  Future<EventsDataDto> getLocalData([int? params]);
  Future<void> cashData({required EventsDataDto data});
}
