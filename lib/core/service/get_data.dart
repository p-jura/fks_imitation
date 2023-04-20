import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';

abstract class GetData<Type> {
  Future<Either<Failure, Type>> call();
}
