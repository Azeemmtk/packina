import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';

import '../../domain/entity/dashboard_data.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../datasource/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, DashboardData>> fetchAdminDashboardData() async {
    try {
      final dashboardData = await remoteDataSource.fetchAdminDashboardData();
      return Right(dashboardData);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch admin dashboard data: $e'));
    }
  }
}