import 'package:packina/features/app/pages/manage_hostel/domain/entity/occupant_entity.dart';

class OccupantModel extends OccupantEntity {
  const OccupantModel({
    required super.id,
    required super.hostelId,
    required super.userId,
    required super.name,
    required super.age,
    required super.phone,
    required super.roomId,
    required super.roomType,
    required super.rentPaid,
    super.addressProofUrl,
    super.idProofUrl,
    super.profileImageUrl,
    super.guardian,
    super.adminAction,
  });

  factory OccupantModel.fromJson(Map<String, dynamic> json) {
    return OccupantModel(
      id: json['id'] ?? '',
      hostelId: json['hostelId'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0,
      phone: json['phone'] ?? '',
      roomId: json['roomId'] ?? '',
      roomType: json['roomType'] ?? '',
      rentPaid: json['rentPaid'] ?? false,
      addressProofUrl: json['addressProofUrl'],
      idProofUrl: json['idProofUrl'],
      profileImageUrl: json['profileImageUrl'],
      guardian: json['guardian'],
      adminAction: json['adminAction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hostelId': hostelId,
      'userId': userId,
      'name': name,
      'age': age,
      'phone': phone,
      'roomId': roomId,
      'roomType': roomType,
      'rentPaid': rentPaid,
      'addressProofUrl': addressProofUrl,
      'idProofUrl': idProofUrl,
      'profileImageUrl': profileImageUrl,
      'guardian': guardian,
      'adminAction': adminAction,
    };
  }

  OccupantEntity toEntity() {
    return OccupantEntity(
      id: id,
      hostelId: hostelId,
      userId: userId,
      name: name,
      age: age,
      phone: phone,
      roomId: roomId,
      roomType: roomType,
      rentPaid: rentPaid,
      addressProofUrl: addressProofUrl,
      idProofUrl: idProofUrl,
      profileImageUrl: profileImageUrl,
      guardian: guardian,
      adminAction: adminAction,
    );
  }
}