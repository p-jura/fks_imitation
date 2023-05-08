part of 'all_categories_events_cubit.dart';

abstract class AllCategoriesEventsState extends Equatable {
  const AllCategoriesEventsState();
}

class AllCategoriesEventsInitial extends AllCategoriesEventsState {
  @override
  List<Object> get props => [];
}

class AllCategoriesEventsLoading extends AllCategoriesEventsState {
  @override
  List<Object> get props => [];
}

class AllCategoriesEventsLoadedState extends AllCategoriesEventsState {
  final Map<int, Map<String, dynamic>> _categoriesWithEvents;

  const AllCategoriesEventsLoadedState({
    required categoriesWithEvents,
  }) : _categoriesWithEvents = categoriesWithEvents;

  Map<int, Map<String, dynamic>> get categoriesWithEvents =>
      Map.from(_categoriesWithEvents);
      
  @override
  List<Object> get props => [_categoriesWithEvents];
}
