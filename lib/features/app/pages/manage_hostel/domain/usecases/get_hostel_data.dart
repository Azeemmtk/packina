import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';
import 'package:packina/core/usecases/usecase.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/repository/hostel_repository.dart';

class GetHostelData extends UseCaseNoParams<List<HostelEntity>> {
  final HostelRepository repository;

  GetHostelData(this.repository);

  @override
  Future<Either<Failure, List<HostelEntity>>> call() async {
    return await repository.getHostelData();
  }
}
