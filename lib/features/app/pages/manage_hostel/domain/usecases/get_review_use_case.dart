
import '../../../../../../core/usecases/usecase.dart';
import '../entity/review_entity.dart';
import '../repository/review_repository.dart';

class GetReviewsUseCase implements StreamUseCase<List<ReviewEntity>, String> {
  final ReviewRepository repository;

  GetReviewsUseCase(this.repository);

  @override
  Stream<List<ReviewEntity>> call(String hostelId) {
    return repository.getReviews(hostelId).map((reviews) => reviews.cast<ReviewEntity>());
  }
}