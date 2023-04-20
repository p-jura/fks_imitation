import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';

abstract class GetData<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
