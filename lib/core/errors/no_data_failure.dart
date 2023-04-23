import 'package:fuksiarz_imitation/core/errors/failure.dart';

class NoDataFoundFailure extends Failure {
  final String? message;

  const NoDataFoundFailure({this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'No data - message: $message';
}
