part of 'all_chat_bloc.dart';

abstract class AllChatsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AllChatsInitial extends AllChatsState {}

class AllChatsLoading extends AllChatsState {}

class AllChatsLoaded extends AllChatsState {
  final List<ChatEntity> chats;
  AllChatsLoaded(this.chats);
  @override
  List<Object> get props => [chats];
}

class AllChatsError extends AllChatsState {
  final String message;
  AllChatsError(this.message);
  @override
  List<Object> get props => [message];
}