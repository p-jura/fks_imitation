import 'package:fuksiarz_imitation/core/errors/failure.dart';

class ServerError extends Failure {
  final int? errorCode;
  final String? message;

  const ServerError({this.errorCode, this.message});

  @override
  List<Object?> get props => [errorCode, message];

  @override
  String toString() => 'ServerError - code: $errorCode, message: $message';
}
