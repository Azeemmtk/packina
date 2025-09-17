import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packina/core/error/exceptions.dart';
import 'package:packina/features/app/pages/home/domain/entity/dashboard_data.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardData> fetchAdminDashboardData();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final FirebaseFirestore firestore;

  DashboardRemoteDataSourceImpl({required this.firestore});

  @override
  Future<DashboardData> fetchAdminDashboardData() async {
    try {
      // Fetch all hostels
      final hostelQuery = await firestore.collection('hostels').get();
      final hostelsCount = hostelQuery.docs.length;

      // Count occupants across all hostels
      int occupantsCount = 0;
      int blockedHostelsCount = 0;
      for (var hostel in hostelQuery.docs) {
        final occupants = (hostel.data()['occupantsId'] as List<dynamic>?) ?? [];
        occupantsCount += occupants.length;
        if (hostel.data()['status'] == 'blocked') {
          blockedHostelsCount++;
        }
      }

      // Fetch pending reports
      final reportsQuery = await firestore
          .collection('reports')
          .where('status', isNotEqualTo: 'resolved')
          .get();
      final pendingReportsCount = reportsQuery.docs.length;

      return DashboardData(
        hostelsCount: hostelsCount,
        pendingReportsCount: pendingReportsCount,
        blockedHostelsCount: blockedHostelsCount,
        occupantsCount: occupantsCount,
      );
    } catch (e) {
      throw ServerException('Failed to fetch admin dashboard data: $e');
    }
  }
}