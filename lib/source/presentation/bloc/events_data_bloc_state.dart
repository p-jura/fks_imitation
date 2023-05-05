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
  final Map<int, Map<String, dynamic>> _categoriesWithEvents;

  AllCategoriesEventsLoadedState({
    required categoriesWithEvents,
  }) : _categoriesWithEvents = categoriesWithEvents;

  Map<int, Map<String, dynamic>> get categoriesWithEvents =>
      Map.of(_categoriesWithEvents);

  @override
  List<Object?> get props => [_categoriesWithEvents];
}

class SingleCategoryEventsLoadedState extends EventsDataBlocState {
  final EventsDataList _eventsDataList;
  final int? _categoryId;
  SingleCategoryEventsLoadedState({
    required EventsDataList eventsDataList,
    required int categoryId,
  })  : _eventsDataList = eventsDataList,
        _categoryId = categoryId;

  EventsDataList get eventsDataList => _eventsDataList;
  int? get categoryId => _categoryId;

  @override
  List<Object?> get props => [_eventsDataList, _categoryId];
}

