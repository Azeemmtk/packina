import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packina/core/utils/enums.dart';

import '../../domain/entity/hostel_entity.dart';

class HostelModel extends HostelEntity{

  const HostelModel({
    required super.id,
    required super.name,
    required super.placeName,
    required super.latitude,
    required super.longitude,
    required super.contactNumber,
    required super.description,
    required super.facilities,
    required super.rooms,
    required super.ownerId,
    required super.ownerName,
    super.mainImageUrl,
    super.mainImagePublicId,
    required super.smallImageUrls,
    required super.smallImagePublicIds,
    required super.createdAt,
    required super.status,
  });

  factory HostelModel.fromEntity( HostelEntity entity) {
    return HostelModel(
      id: entity.id,
      name: entity.name,
      placeName: entity.placeName,
      latitude: entity.latitude,
      longitude: entity.longitude,
      contactNumber: entity.contactNumber,
      description: entity.description,
      facilities: entity.facilities,
      rooms: entity.rooms,
      ownerId: entity.ownerId,
      ownerName: entity.ownerName,
      mainImageUrl: entity.mainImageUrl,
      mainImagePublicId: entity.mainImagePublicId,
      smallImageUrls: entity.smallImageUrls,
      smallImagePublicIds: entity.smallImagePublicIds,
      createdAt: entity.createdAt,
      status: entity.status, // New field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'placeName': placeName,
      'latitude': latitude,
      'longitude': longitude,
      'contactNumber': contactNumber,
      'description': description,
      'facilities': facilities,
      'rooms': rooms,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'mainImageUrl': mainImageUrl,
      'mainImagePublicId': mainImagePublicId,
      'smallImageUrls': smallImageUrls,
      'smallImagePublicIds': smallImagePublicIds,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.value,
    };
  }

  HostelEntity toEntity() {
    return HostelEntity(
      id: id,
      name: name,
      placeName: placeName,
      latitude: latitude,
      longitude: longitude,
      contactNumber: contactNumber,
      description: description,
      facilities: facilities,
      rooms: rooms,
      ownerId: ownerId,
      ownerName: ownerName,
      mainImageUrl: mainImageUrl,
      mainImagePublicId: mainImagePublicId,
      smallImageUrls: smallImageUrls,
      smallImagePublicIds: smallImagePublicIds,
      createdAt: createdAt,
      status: status,
    );
  }

  factory HostelModel.fromJson(Map<String, dynamic> json) {
    return HostelModel(
      id: json['id'],
      name: json['name'],
      placeName: json['placeName'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      contactNumber: json['contactNumber'],
      description: json['description'],
      facilities: List<String>.from(json['facilities']),
      rooms: List<Map<String, dynamic>>.from(json['rooms']),
      ownerId: json['ownerId'],
      ownerName: json['ownerName'],
      mainImageUrl: json['mainImageUrl'],
      mainImagePublicId: json['mainImagePublicId'],
      smallImageUrls: List<String>.from(json['smallImageUrls']),
      smallImagePublicIds: List<String>.from(json['smallImagePublicIds']),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      status: StatusExtension.fromString(json['status'] ?? 'pending')
    );
  }
}