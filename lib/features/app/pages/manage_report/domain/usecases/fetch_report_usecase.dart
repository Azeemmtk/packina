import 'package:dartz/dartz.dart';
import '../../../../../../../core/usecases/usecase.dart';
import '../../../../../../core/error/failures.dart';
import '../entity/report_entity.dart';
import '../repository/report_repository.dart';

class FetchReportsUseCase implements UseCaseNoParams<List<ReportEntity>> {
  final ReportRepository repository;

  FetchReportsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ReportEntity>>> call() async {
    return await repository.fetchReports();
  }
}