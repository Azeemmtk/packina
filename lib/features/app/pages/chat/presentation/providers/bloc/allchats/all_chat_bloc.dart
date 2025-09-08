import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/chat_entity.dart';
import '../../../../domain/usecases/get_chats_use_case.dart';

part 'all_chat_event.dart';
part 'all_chat_state.dart';

class AllChatBloc extends Bloc<AllChatsEvent, AllChatsState> {
  final GetChatsUseCase getChatsUseCase;
  late StreamSubscription<List<ChatEntity>> _subscription;

  AllChatBloc(this.getChatsUseCase) : super(AllChatsInitial()) {
    on<LoadChatsEvent>(_onLoadChats);
    on<UpdateChatsEvent>(_onUpdateChats);
    on<ErrorChatsEvent>(_onErrorChats);
  }

  Future<void> _onLoadChats(
      LoadChatsEvent event, Emitter<AllChatsState> emit) async {
    emit(AllChatsLoading());
    _subscription = getChatsUseCase().listen(
        (chats) => add(UpdateChatsEvent(chats)),
        onError: (error) => add(ErrorChatsEvent(error.toString())));
  }

  Future<void> _onUpdateChats(UpdateChatsEvent event, Emitter<AllChatsState> emit) async{
    emit(AllChatsLoaded(event.chats));
  }

  Future<void> _onErrorChats(ErrorChatsEvent event, Emitter<AllChatsState> emit) async {
    emit(AllChatsError(event.message));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
