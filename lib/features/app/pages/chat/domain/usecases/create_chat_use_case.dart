import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repository/chat_repository.dart';

class CreateChatUseCase extends UseCase<String, CreateChatParams> {
  final ChatRepository repository;

  CreateChatUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(CreateChatParams params) async {
    return await repository.createChat(params.userId, collection: params.collection);
  }
}


class CreateChatParams {
  final String userId;
  final String collection;

  CreateChatParams({required this.userId, this.collection = 'hostel_owners'});
}