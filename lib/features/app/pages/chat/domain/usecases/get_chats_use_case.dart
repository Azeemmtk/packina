
import '../../../../../../core/usecases/usecase.dart';
import '../entity/chat_entity.dart';
import '../repository/chat_repository.dart';

class GetChatsUseCase extends StreamUseCaseNoParams<List<ChatEntity>> {
  final ChatRepository repository;

  GetChatsUseCase(this.repository);

  @override
  Stream<List<ChatEntity>> call() {
    return repository.getChats();
  }
}
