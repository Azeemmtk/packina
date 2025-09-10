import 'package:flutter/material.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../domain/entity/chat_entity.dart';
import '../screens/individual_chat_screen.dart';

class AllChatCardWidget extends StatelessWidget {
  const AllChatCardWidget({
    super.key,
    required this.chat,
    required this.otherName,
    required this.otherPhoto,
    required this.lastMessage,
    required this.time,
  });

  final ChatEntity chat;
  final String otherName;
  final String otherPhoto;
  final String lastMessage;
  final String time;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChatScreen(
              chatId: chat.id,
              otherName: otherName,
              otherPhoto: otherPhoto,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundImage: otherPhoto.isNotEmpty
                  ? NetworkImage(otherPhoto)
                  : null,
              child: otherPhoto.isEmpty
                  ? Text(
                otherName.isNotEmpty ? otherName[0] : 'U',
                style: const TextStyle(fontSize: 18),
              )
                  : null,
            ),
            width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherName,
                    style: TextStyle(fontSize: 18, color: headingTextColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    lastMessage,
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(time),
              ],
            ),
          ],
        ),
      ),
    );
  }
}