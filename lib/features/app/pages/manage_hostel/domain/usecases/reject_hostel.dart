import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';
import 'package:packina/core/usecases/usecase.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/repository/hostel_repository.dart';

class RejectHostel extends UseCase<String, String> {
  final HostelRepository repository;

  RejectHostel(this.repository);

  @override
  Future<Either<Failure, String>> call(String hostelId) async{
    return await repository.rejectHostel(hostelId);
  }
}
