import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';

class ChatAppBarWidget extends StatelessWidget {
  const ChatAppBarWidget({
    super.key,
    required this.title,
    required this.photoUrl,
    this.enableChat = false,
  });

  final String title;
  final String photoUrl;
  final bool enableChat;

  @override
  Widget build(BuildContext context) {
    // Debug logging to verify inputs
    debugPrint('ChatAppBarWidget: title=$title, photoUrl=$photoUrl');

    return Container(
      height: height * 0.12,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(width * 0.1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: height * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.pop(context);
                  debugPrint('ChatAppBarWidget: Back button pressed, popped route');
                } else {
                  debugPrint('ChatAppBarWidget: Cannot pop, no route to pop');
                  // Fallback navigation (e.g., to AdminChatScreen or HomeScreen)
                  Navigator.pushReplacementNamed(context, '/admin_chat');
                }
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.black, // Ensure visibility
              ),
            ),
            const SizedBox(width: 10), // Replace width10 with fixed value
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.grey[300],
              backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
              onBackgroundImageError: photoUrl.isNotEmpty
                  ? (error, stackTrace) {
                debugPrint('ChatAppBarWidget: Failed to load photoUrl=$photoUrl, error=$error');
              }
                  : null,
              child: photoUrl.isEmpty
                  ? Text(
                title.isNotEmpty ? title[0].toUpperCase() : 'U',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              )
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title.isNotEmpty ? title : 'Unknown',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF374151),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    'online',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}