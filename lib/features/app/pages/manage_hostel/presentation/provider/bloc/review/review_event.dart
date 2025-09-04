part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class FetchReviews extends ReviewEvent {
  final String hostelId;

  const FetchReviews(this.hostelId);

  @override
  List<Object> get props => [hostelId];
}