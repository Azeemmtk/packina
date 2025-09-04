import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/enums.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String hostelId;
  final String userId;
  final String userName;
  final String? userImageUrl;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final Status status;

  const ReviewEntity({
    required this.id,
    required this.hostelId,
    required this.userId,
    required this.userName,
    this.userImageUrl,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    hostelId,
    userId,
    userName,
    userImageUrl,
    rating,
    comment,
    createdAt,
    status,
  ];
}