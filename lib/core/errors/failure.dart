import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? errorCode;
  final String? message;
  const Failure(this.message, [this.errorCode]);

  @override
  List<Object?> get props => [message];
}

class ServerOrClientError extends Failure {
  const ServerOrClientError({
    errorCode,
    message,
  }) : super(message, errorCode);

  @override
  List<Object?> get props => [errorCode, message];

  @override
  String toString() => 'ServerError - code: $errorCode, message: $message';
}

class NoDataFoundFailure extends Failure {
  const NoDataFoundFailure({message}) : super(message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'No data - message: $message';
}

class NoDataCached extends Failure {
  const NoDataCached(super.message);
}
