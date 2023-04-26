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

class SingleCategoryEventsLoadedState extends EventsDataBlocState {
  final EventsDataList eventsDataList;

  SingleCategoryEventsLoadedState({required this.eventsDataList});

  @override
  List<Object?> get props => [eventsDataList];
}

class AllCategoriesEventsLoadedState extends EventsDataBlocState {
  final List<EventsDataList> allCategoriesEventsList;
  final List<Map<String, dynamic>> listOfMappedCatWithEventsCount;
  AllCategoriesEventsLoadedState({
    required this.allCategoriesEventsList,
    required this.listOfMappedCatWithEventsCount,
  });

  @override
  List<Object?> get props => [allCategoriesEventsList];
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
