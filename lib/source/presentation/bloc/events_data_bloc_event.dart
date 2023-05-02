import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventsDataBlocEvent extends Equatable {}

class GetEventsFromRemoteSingleCategory extends EventsDataBlocEvent {
  GetEventsFromRemoteSingleCategory();

  @override
  List<Object?> get props => [];
}

class GetEventsFromRemoteAllCategories extends EventsDataBlocEvent {
  final int? categoiresAmmount;

  GetEventsFromRemoteAllCategories([this.categoiresAmmount]);

  @override
  List<Object?> get props => [categoiresAmmount];
}

class GetQueryFromRemote extends EventsDataBlocEvent {
  final String query;

  GetQueryFromRemote({required this.query});

  @override
  List<Object?> get props => [query];
}
