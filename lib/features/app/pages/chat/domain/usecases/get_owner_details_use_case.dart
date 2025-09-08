import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repository/owner_repository.dart';

class GetOwnerDetailsUseCase implements UseCase<Map<String, String>, GetOwnerDetailsParams> {
  final OwnerRepository repository;

  GetOwnerDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, String>>> call(GetOwnerDetailsParams params) {
    return repository.getOwnerDetails(params.userId, collection: params.collection);
  }
}

class GetOwnerDetailsParams {
  final String userId;
  final String collection;

  GetOwnerDetailsParams({required this.userId, this.collection = 'hostel_owners'});
}