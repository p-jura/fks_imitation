import 'package:equatable/equatable.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';

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
  final QuickSearchResponseList qickSearchEventList;

  QueryLoadedState({required this.qickSearchEventList});

  @override
  List<Object?> get props => [qickSearchEventList];
}

class NoDataFoundState extends QueryState {
  final String message;

  NoDataFoundState(this.message);
  @override
  List<Object?> get props => [message];
}
