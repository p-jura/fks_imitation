part of 'single_category_event_cubit.dart';

abstract class SingleCategoryEventState extends Equatable {
  const SingleCategoryEventState();

  @override
  List<Object> get props => [];
}

class SingleCategoryEventInitial extends SingleCategoryEventState {}

class SingleCategoryLoadingState extends SingleCategoryEventState {
  const SingleCategoryLoadingState();
}

class SingleCategoryEventsLoadedState extends SingleCategoryEventState {
  final EventsDataList _eventsDataList;
  final int? _categoryId;
  const SingleCategoryEventsLoadedState({
    required EventsDataList eventsDataList,
    required int categoryId,
  })  : _eventsDataList = eventsDataList,
        _categoryId = categoryId;

  EventsDataList get eventsDataList => _eventsDataList;
  int? get categoryId => _categoryId;
}
