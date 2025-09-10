import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';
import 'package:packina/core/usecases/usecase.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/occupant_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/repository/occupant_repository.dart';

class GetOccupantsByHostelId extends UseCase<List<OccupantEntity>, String> {
  final OccupantRepository repository;

  GetOccupantsByHostelId(this.repository);

  @override
  Future<Either<Failure, List<OccupantEntity>>> call(String params) async {
    return await repository.getOccupantsByHostelId(params);
  }
}