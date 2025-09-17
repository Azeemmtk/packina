import 'package:equatable/equatable.dart';

class OccupantEntity extends Equatable {
  final String id;
  final String hostelId;
  final String userId;
  final String name;
  final int age;
  final String phone;
  final String roomId;
  final String roomType;
  final bool rentPaid;
  final String? addressProofUrl;
  final String? idProofUrl;
  final String? profileImageUrl;
  final Map<String, dynamic>? guardian;
  final String? adminAction;

  const OccupantEntity({
    required this.id,
    required this.hostelId,
    required this.userId,
    required this.name,
    required this.age,
    required this.phone,
    required this.roomId,
    required this.roomType,
    required this.rentPaid,
    this.addressProofUrl,
    this.idProofUrl,
    this.profileImageUrl,
    this.guardian,
    this.adminAction,
  });

  @override
  List<Object?> get props => [
    id,
    hostelId,
    userId,
    name,
    age,
    phone,
    roomId,
    roomType,
    rentPaid,
    addressProofUrl,
    idProofUrl,
    profileImageUrl,
    guardian,
    adminAction,
  ];
}