part of 'all_chat_bloc.dart';

abstract class AllChatsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadChatsEvent extends AllChatsEvent {}

class UpdateChatsEvent extends AllChatsEvent {
  final List<ChatEntity> chats;
  UpdateChatsEvent(this.chats);
  @override
  List<Object> get props => [chats];
}

class ErrorChatsEvent extends AllChatsEvent {
  final String message;
  ErrorChatsEvent(this.message);
  @override
  List<Object> get props => [message];
}