import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/report_entity.dart';

abstract class ReportDataSource {
  Future<List<ReportEntity>> fetchReports();
  Future<bool> updateReportStatus(String reportId, String status, String action);
  Future<bool> blockHostel(String hostelId);
}

class ReportDataSourceImpl implements ReportDataSource {
  final FirebaseFirestore firestore;

  ReportDataSourceImpl({required this.firestore});

  @override
  Future<List<ReportEntity>> fetchReports() async {
    final snapshot = await firestore.collection('reports').get();
    return snapshot.docs
        .map((doc) => ReportEntity.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<bool> updateReportStatus(String reportId, String status, String action) async {
    try {
      await firestore.collection('reports').doc(reportId).update({
        'status': status,
        'adminAction': action,
      });
      return true;
    } catch (e) {
      print('Error updating report status: $e');
      return false;
    }
  }

  @override
  Future<bool> blockHostel(String hostelId) async {
    try {
      await firestore.collection('hostels').doc(hostelId).update({
        'status': 'blocked',
        'adminAction': 'Blocked on ${DateTime.now()}',
      });
      return true;
    } catch (e) {
      print('Error blocking hostel: $e');
      return false;
    }
  }
}