import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';

import '../model/hostel_model.dart';

abstract class HostelRemoteDataSource {
  Future<Either<Failure, List<HostelEntity>>> getHostelData();
  Future<Either<Failure, String>> approveHostel(String hostelId);
}

class HostelRemoteDataSourceImpl implements HostelRemoteDataSource {
  final FirebaseFirestore firestore;

  HostelRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failure, List<HostelEntity>>> getHostelData() async {
    try {
      final querySnapshot = await firestore.collection('hostels').get();
      final hostels = querySnapshot.docs
          .map((doc) => HostelModel.fromJson(doc.data()).toEntity())
          .toList();
      return Right(hostels);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch hostels: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> approveHostel(String hostelId) async {
    try{
      await firestore.collection('hostels').doc(hostelId).
      update({'approved':true});
      return Right(hostelId);
    } catch (e){
      return Left(ServerFailure('Failed to approve hostel: $e'));
    }
  }
}
