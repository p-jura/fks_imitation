import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventsDataBlocEvent extends Equatable {}

class GetEventsFromRemote extends EventsDataBlocEvent {
  final int? catalogId;

  GetEventsFromRemote(this.catalogId);

  @override
  List<Object?> get props => [catalogId];
}

class GetQueryFromRemote extends EventsDataBlocEvent {
  final String query;

  GetQueryFromRemote({required this.query});

  @override
  List<Object?> get props => [query];
}
