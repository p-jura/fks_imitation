import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final int? code;
  final String? message;

  const ServerException([this.code, this.message]);
  
  @override

  List<Object?> get props => [code, message];
}
