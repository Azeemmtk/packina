import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entity/chat_entity.dart';
import '../entity/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, String>> createChat(String otherUserId, {String collection = 'hostel_owners'});
  Future<Either<Failure, void>> sendMessage(String chatId, String text);
  Stream<List<ChatEntity>> getChats();
  Stream<List<MessageEntity>> getMessages(String chatId);
}