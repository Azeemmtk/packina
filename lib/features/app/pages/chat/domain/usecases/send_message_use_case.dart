import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repository/chat_repository.dart';

class SendMessageUseCase extends UseCase<void, SendMessageParams> {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return repository.sendMessage(params.chatId, params.text);
  }
}

class SendMessageParams {
  final String chatId;
  final String text;

  SendMessageParams(this.chatId, this.text);
}
