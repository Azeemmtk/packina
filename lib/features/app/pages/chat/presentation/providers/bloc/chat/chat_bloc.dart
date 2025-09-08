import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entity/message_entity.dart';
import '../../../../domain/usecases/get_messages_use_case.dart';
import '../../../../domain/usecases/send_message_use_case.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final String chatId;
  late StreamSubscription<List<MessageEntity>> _subscription;

  ChatBloc({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.chatId,
  }) : super(ChatInitial()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<UpdateMessagesEvent>(_onUpdateMessages);
    on<ErrorMessageEvent>(_onError);
  }

  Future<void> _onLoadMessages(LoadMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    _subscription = getMessagesUseCase(chatId).listen(
          (messages) => add(UpdateMessagesEvent(messages)),
      onError: (error) => add(ErrorMessageEvent(error.toString())),
    );
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    final result = await sendMessageUseCase(SendMessageParams(chatId, event.text));
    result.fold(
          (failure) => add(ErrorMessageEvent(failure.message)),
          (_) => {},  // Stream will auto-update
    );
  }

  Future<void> _onUpdateMessages(UpdateMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoaded(event.messages));
  }

  Future<void> _onError(ErrorMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatError(event.message));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}