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

class LoadedState extends EventsDataBlocState {
  final EventsDataList eventsDataList;

  LoadedState({required this.eventsDataList});

  @override
  List<Object?> get props => [eventsDataList];
}

class NoDataFoundState extends EventsDataBlocState {
  final String message;

  NoDataFoundState(this.message);
  @override
  List<Object?> get props => [message];
}
