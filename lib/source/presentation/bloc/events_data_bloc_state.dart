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

class EventLoadedState extends EventsDataBlocState {
  final EventsDataList eventsDataList;

  EventLoadedState({required this.eventsDataList});

  @override
  List<Object?> get props => [eventsDataList];
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
