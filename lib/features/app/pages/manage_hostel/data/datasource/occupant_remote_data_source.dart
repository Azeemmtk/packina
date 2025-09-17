import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:packina/core/error/failures.dart';

import '../../domain/entity/occupant_entity.dart';
import '../model/occupant_model.dart';

abstract class OccupantRemoteDataSource {
  Future<Either<Failure, List<OccupantEntity>>> getOccupantsByHostelId(String hostelId);
}

class OccupantRemoteDataSourceImpl implements OccupantRemoteDataSource {
  final FirebaseFirestore firestore;

  OccupantRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failure, List<OccupantEntity>>> getOccupantsByHostelId(String hostelId) async {
    try {
      print('========================1----$hostelId');
      final querySnapshot = await firestore
          .collection('occupants')
          .where('hostelId', isEqualTo: hostelId)
          .get();
      print('========================2 ${querySnapshot.docs}');
      final occupants = querySnapshot.docs
          .map((doc) => OccupantModel.fromJson(doc.data()).toEntity())
          .toList();
      print('========================$occupants');
      return Right(occupants);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch occupants: $e'));
    }
  }
}