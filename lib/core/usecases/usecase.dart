import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

abstract class StreamUseCaseNoParams<Type> {
  Stream<Type> call();
}

class NoParams {
  const NoParams();
}
