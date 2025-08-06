import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';

abstract class HostelRepository{
  Future<Either<Failure, List<HostelEntity>>> getHostelData();
  Future<Either<Failure, String>> approveHostel(String hostelId);

}