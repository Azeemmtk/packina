import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../core/utils/enums.dart';
import '../../domain/entity/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    required super.hostelId,
    required super.userId,
    required super.userName,
    super.userImageUrl,
    required super.rating,
    required super.comment,
    required super.createdAt,
    required super.status,
  });

  factory ReviewModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReviewModel(
      id: doc.id,
      hostelId: data['hostelId'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userImageUrl: data['userImageUrl'],
      rating: data['rating'] ?? 0,
      comment: data['comment'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      status: Status.values.firstWhere(
            (e) => e.toString() == data['status'],
        orElse: () => Status.active,
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'hostelId': hostelId,
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
      'rating': rating,
      'comment': comment,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.toString(),
    };
  }
}