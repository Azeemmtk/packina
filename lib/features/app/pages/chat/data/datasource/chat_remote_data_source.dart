import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../app_state.dart';
import '../../../../../../core/error/exceptions.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/entity/message_entity.dart';

abstract class ChatRemoteDataSource {
  Future<String> createChat(String otherUserId, {String collection = 'hostel_owners'});
  Future<void> sendMessage(String chatId, String text);
  Stream<List<MessageEntity>> getMessages(String chatId);
  Stream<List<ChatEntity>> getChats();
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatRemoteDataSourceImpl(this.firestore);

  @override
  Future<String> createChat(String otherUserId, {String collection = 'hostel_owners'}) async {
    try {
      String currentUId;
      String currentName;
      String currentPhoto;

      if (AppState.isAdmin) {
        currentUId = AppState.adminUid;
        currentName = AppState.adminDisplayName;
        currentPhoto = AppState.adminPhotoURL;
      } else {
        final currentUser = FirebaseAuth.instance.currentUser!;
        currentUId = currentUser.uid;
        currentName = currentUser.displayName ?? 'Unknown';
        currentPhoto = currentUser.photoURL ?? '';
      }

      // Fetch hostel owner
      final otherDoc = await firestore.collection(collection).doc(otherUserId).get();
      if (!otherDoc.exists) {
        throw ServerException('Hostel owner not found');
      }
      final otherName = otherDoc['displayName'] ?? 'Unknown';
      final otherPhoto = otherDoc['photoURL'] ?? '';

      // Unique chat ID
      final ids = [currentUId, otherUserId]..sort();
      final chatId = ids.join('_');

      final chatRef = firestore.collection('chats').doc(chatId);
      final snapshot = await chatRef.get();

      if (!snapshot.exists) {
        await chatRef.set({
          'participants': [currentUId, otherUserId],
          'participantsInfo': {
            currentUId: {
              'name': currentName,
              'photo': currentPhoto,
            },
            otherUserId: {'name': otherName, 'photo': otherPhoto}
          },
          'lastMessage': '',
          'lastTimestamp': FieldValue.serverTimestamp(),
        });
      }
      return chatId;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<ChatEntity>> getChats() {
    final currentUid = AppState.isAdmin
        ? AppState.adminUid
        : FirebaseAuth.instance.currentUser!.uid;
    return firestore
        .collection('chats')
        .where('participants', arrayContains: currentUid)
        .orderBy('lastTimestamp', descending: true)
        .snapshots()
        .map((query) => query.docs.map(
          (doc) {
        final info = doc['participantsInfo'] as Map<String, dynamic>;
        return ChatEntity(
          id: doc.id,
          participants: List<String>.from(doc['participants']),
          participantsInfo: info
              .map((k, v) => MapEntry(k, Map<String, String>.from(v))),
          lastMessage: doc['lastMessage'] ?? '',
          lastTimestamp:
          (doc['lastTimestamp'] as Timestamp?)?.toDate() ??
              DateTime.now(),
        );
      },
    ).toList());
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((query) => query.docs
        .where((doc) => doc['timestamp'] != null)
        .map((doc) => MessageEntity(
      id: doc.id,
      text: doc['text'],
      senderId: doc['senderId'],
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
    ))
        .toList());
  }

  @override
  Future<void> sendMessage(String chatId, String text) async {
    try {
      final currentUid = AppState.isAdmin
          ? AppState.adminUid
          : FirebaseAuth.instance.currentUser!.uid;
      final chatRef = firestore.collection('chats').doc(chatId);
      final messageRef = chatRef.collection('messages').doc();

      await messageRef.set({
        'text': text,
        'senderId': currentUid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update chat metadata
      await chatRef.update({
        'lastMessage': text,
        'lastTimestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}