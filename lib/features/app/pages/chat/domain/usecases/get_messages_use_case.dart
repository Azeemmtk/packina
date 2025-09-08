import '../../../../../../core/usecases/usecase.dart';
import '../entity/message_entity.dart';
import '../repository/chat_repository.dart';

class GetMessagesUseCase extends StreamUseCase<List<MessageEntity>, String> {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  @override
  Stream<List<MessageEntity>> call(String params) {
    return repository.getMessages(params);
  }
}
