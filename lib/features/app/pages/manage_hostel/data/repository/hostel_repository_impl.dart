import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';
import 'package:packina/features/app/pages/manage_hostel/data/datasource/hostel_remote_data_source.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/repository/hostel_repository.dart';

class HostelRepositoryImpl implements HostelRepository {
  final HostelRemoteDataSource hostelRemoteDataSource;

  HostelRepositoryImpl( this.hostelRemoteDataSource);

  @override
  Future<Either<Failure, List<HostelEntity>>> getHostelData() async {
    return await hostelRemoteDataSource.getHostelData();
  }

  @override
  Future<Either<Failure, String>> approveHostel(String hostelId) async{
    return await hostelRemoteDataSource.approveHostel(hostelId);
  }
}
