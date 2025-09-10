import 'package:dartz/dartz.dart';
import '../../../../../../core/error/exceptions.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/entity/report_entity.dart';
import '../../domain/repository/report_repository.dart';
import '../datasource/report_data_source.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportDataSource dataSource;

  ReportRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<ReportEntity>>> fetchReports() async {
    try {
      final reports = await dataSource.fetchReports();
      return Right(reports);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to fetch reports: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateReportStatus(String reportId, String status) async {
    try {
      final success = await dataSource.updateReportStatus(reportId, status);
      return Right(success);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to update report status: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> blockHostel(String hostelId) async {
    try {
      final success = await dataSource.blockHostel(hostelId);
      return Right(success);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to block hostel: $e'));
    }
  }
}