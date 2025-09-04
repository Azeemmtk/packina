import '../../domain/repository/review_repository.dart';
import '../datasource/review_remote_data_source.dart';
import '../model/review_model.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<ReviewModel>> getReviews(String hostelId) {
    return remoteDataSource.getReviews(hostelId);
  }
}