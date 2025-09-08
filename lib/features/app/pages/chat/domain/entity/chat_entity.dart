import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final List<String> participants;
  final Map<String, Map<String, String>> participantsInfo;
  final String lastMessage;
  final DateTime lastTimestamp;

  const ChatEntity({
    required this.id,
    required this.participants,
    required this.participantsInfo,
    required this.lastMessage,
    required this.lastTimestamp,
  });

  @override
  List<Object> get props => [id, participants, participantsInfo, lastMessage, lastTimestamp];
}