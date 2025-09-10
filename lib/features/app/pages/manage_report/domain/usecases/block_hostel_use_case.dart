import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repository/report_repository.dart';

class BlockHostelUseCase implements UseCase<bool, BlockHostelParams> {
  final ReportRepository repository;

  BlockHostelUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(BlockHostelParams params) async {
    return await repository.blockHostel(params.hostelId);
  }
}

class BlockHostelParams {
  final String hostelId;

  BlockHostelParams({required this.hostelId});
}