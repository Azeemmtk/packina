import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/occupant_entity.dart';

abstract class OccupantRepository {
  Future<Either<Failure, List<OccupantEntity>>> getOccupantsByHostelId(String hostelId);
}