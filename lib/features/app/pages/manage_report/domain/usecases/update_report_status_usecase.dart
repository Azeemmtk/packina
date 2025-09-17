import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../domain/repository/report_repository.dart';

class UpdateReportStatusUseCase implements UseCase<bool, UpdateReportStatusParams> {
  final ReportRepository repository;

  UpdateReportStatusUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateReportStatusParams params) async {
    return await repository.updateReportStatus(params.reportId, params.status, params.action);
  }
}

class UpdateReportStatusParams {
  final String reportId;
  final String status;
  final String action;

  UpdateReportStatusParams({required this.reportId, required this.status, required this.action});
}