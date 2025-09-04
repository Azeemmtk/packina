import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../core/error/exceptions.dart';
import '../model/review_model.dart';

abstract class ReviewRemoteDataSource {
  Stream<List<ReviewModel>> getReviews(String hostelId);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final FirebaseFirestore firestore;

  ReviewRemoteDataSourceImpl(this.firestore);


  @override
  Stream<List<ReviewModel>> getReviews(String hostelId) {
    try {
      return firestore
          .collection('reviews')
          .where('hostelId', isEqualTo: hostelId)
          .where('status', isEqualTo: 'Status.active')
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => ReviewModel.fromFirestore(doc))
          .toList());
    } catch (e) {
      throw ServerException('Failed to fetch reviews: $e');
    }
  }
}