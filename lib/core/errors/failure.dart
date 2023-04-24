import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List props = const <dynamic>[]]) : super();
}

class ServerOrClientError extends Failure {
  final int? errorCode;
  final String? message;

  const ServerOrClientError({this.errorCode, this.message});

  @override
  List<Object?> get props => [errorCode, message];

  @override
  String toString() => 'ServerError - code: $errorCode, message: $message';
}

class NoDataFoundFailure extends Failure {
  final String? message;

  const NoDataFoundFailure({this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'No data - message: $message';
}
