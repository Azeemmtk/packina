// import 'package:equatable/equatable.dart';
//
// class ChatUserEntity extends Equatable {
//   final String uid;
//   final String displayName;
//   final String photoURL;
//
//   const ChatUserEntity({
//     required this.uid,
//     required this.displayName,
//     required this.photoURL,
//   });
//
//   factory ChatUserEntity.fromMap(Map<String, dynamic> map, String uid) {
//     return ChatUserEntity(
//       uid: uid,
//       displayName: map['displayName'] ?? 'Unknown',
//       photoURL: map['photoURL'] ?? '',
//     );
//   }
//
//   @override
//   List<Object> get props => [uid, displayName, photoURL];
// }