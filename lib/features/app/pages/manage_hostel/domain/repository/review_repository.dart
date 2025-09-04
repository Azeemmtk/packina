import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../data/model/review_model.dart';

abstract class ReviewRepository {
  Stream<List<ReviewModel>> getReviews(String hostelId);
}
