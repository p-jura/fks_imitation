import 'package:fuksiarz_imitation/source/data/models.dart';

abstract class RemoteDataSources {
  Future<EventsDataDto> getListOfEventsData();
}
