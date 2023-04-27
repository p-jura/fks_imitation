import 'package:equatable/equatable.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';

abstract class EventsDataBlocState extends Equatable {}

class EmptyState extends EventsDataBlocState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends EventsDataBlocState {
  @override
  List<Object?> get props => [];
}



class AllCategoriesEventsLoadedState extends EventsDataBlocState {
  final List<EventsDataList> _allCategoriesEventsList;
  final List<Map<String, dynamic>> _listOfMappedCatWithEventsCount;

  AllCategoriesEventsLoadedState({
    required allCategoriesEventsList,
    required listOfMappedCatWithEventsCount,
  })  : _allCategoriesEventsList = allCategoriesEventsList,
        _listOfMappedCatWithEventsCount = listOfMappedCatWithEventsCount;

  List<EventsDataList> get allEventsDataList => [..._allCategoriesEventsList];

  List<Map<String, dynamic>> get mappedCatWithEventsCount =>
      [..._listOfMappedCatWithEventsCount];

  @override
  List<Object?> get props =>
      [_allCategoriesEventsList, _listOfMappedCatWithEventsCount];
}

class QueryLoadedState extends EventsDataBlocState {
  final QuickSearchResponseList qickSearchEventList;

  QueryLoadedState({required this.qickSearchEventList});

  @override
  List<Object?> get props => [qickSearchEventList];
}

class NoDataFoundState extends EventsDataBlocState {
  final String message;

  NoDataFoundState(this.message);
  @override
  List<Object?> get props => [message];
}
