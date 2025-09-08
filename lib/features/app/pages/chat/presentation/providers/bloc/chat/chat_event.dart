part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMessagesEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String text;
  SendMessageEvent(this.text);
  @override
  List<Object> get props => [text];
}

class UpdateMessagesEvent extends ChatEvent {
  final List<MessageEntity> messages;
  UpdateMessagesEvent(this.messages);
  @override
  List<Object> get props => [messages];
}

class ErrorMessageEvent extends ChatEvent {
  final String message;
  ErrorMessageEvent(this.message);
  @override
  List<Object> get props => [message];
}