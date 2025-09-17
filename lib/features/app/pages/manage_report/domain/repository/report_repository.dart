import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entity/report_entity.dart';

abstract class ReportRepository {
  Future<Either<Failure, List<ReportEntity>>> fetchReports();
  Future<Either<Failure, bool>> updateReportStatus(String reportId, String status, String action);
  Future<Either<Failure, bool>> blockHostel(String hostelId);
}