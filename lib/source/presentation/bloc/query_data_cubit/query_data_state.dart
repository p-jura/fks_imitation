part of 'query_data_cubit.dart';

abstract class QueryState extends Equatable {}

class InitialQueryState extends QueryState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends QueryState {
  @override
  List<Object?> get props => [];
}

class QueryLoadedState extends QueryState {

  final EventsDataList eventsDataList;
  QueryLoadedState({

    required this.eventsDataList,
  });

  @override
  List<Object?> get props => [eventsDataList];
}

class NoDataFoundState extends QueryState {
  final String message;

  NoDataFoundState(this.message);
  @override
  List<Object?> get props => [message];
}
