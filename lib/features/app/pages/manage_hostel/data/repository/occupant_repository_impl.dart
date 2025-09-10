import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';
import 'package:packina/features/app/pages/manage_hostel/data/datasource/occupant_remote_data_source.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/occupant_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/repository/occupant_repository.dart';

class OccupantRepositoryImpl implements OccupantRepository {
  final OccupantRemoteDataSource occupantRemoteDataSource;

  OccupantRepositoryImpl(this.occupantRemoteDataSource);

  @override
  Future<Either<Failure, List<OccupantEntity>>> getOccupantsByHostelId(String hostelId) async {
    return await occupantRemoteDataSource.getOccupantsByHostelId(hostelId);
  }
}