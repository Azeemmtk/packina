import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String text;
  final String senderId;
  final DateTime timestamp;

  const MessageEntity({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
  });

  @override
  List<Object> get props => [id, text, senderId, timestamp];
}