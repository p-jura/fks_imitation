import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';

abstract class RemoteDataSorces {
  Future<EventsDataList> getListOfEventsData();
}
