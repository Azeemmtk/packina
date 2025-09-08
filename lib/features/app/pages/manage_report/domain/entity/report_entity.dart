import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReportEntity extends Equatable {
  final String? id;
  final String message;
  final String? imageUrl;
  final String senderId;
  final String hostelId;
  final String ownerId;
  final DateTime createdAt;
  final String status;
  final String? adminAction;

  const ReportEntity({
    this.id,
    required this.message,
    this.imageUrl,
    required this.senderId,
    required this.hostelId,
    required this.ownerId,
    required this.createdAt,
    required this.status,
    this.adminAction,
  });

  @override
  List<Object?> get props => [
    id,
    message,
    imageUrl,
    senderId,
    hostelId,
    ownerId,
    createdAt,
    status,
    adminAction,
  ];

  // Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'imageUrl': imageUrl,
      'senderId': senderId,
      'hostelId': hostelId,
      'ownerId': ownerId,
      'createdAt': createdAt,
      'status': status,
      'adminAction': adminAction,
    };
  }

  // Create from Firestore map
  factory ReportEntity.fromMap(Map<String, dynamic> map, String id) {
    return ReportEntity(
      id: id,
      message: map['message'] as String,
      imageUrl: map['imageUrl'] as String?,
      senderId: map['senderId'] as String,
      hostelId: map['hostelId'] as String,
      ownerId: map['ownerId'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      status: map['status'] as String,
      adminAction: map['adminAction'] as String?,
    );
  }
}