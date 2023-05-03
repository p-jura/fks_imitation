import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class QueryDataEvent extends Equatable {}

class GetQueryFromRemote extends QueryDataEvent {
  final String query;

  GetQueryFromRemote({required this.query});

  @override
  List<Object?> get props => [query];
}

class ResetQuery extends QueryDataEvent {
  @override
  List<Object?> get props => [];
}
