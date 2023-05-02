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
      Map.from(_categoriesWithEvents);

  @override
  List<Object?> get props => [_categoriesWithEvents];
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
