import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../constants/const.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.enableChat = false,
  });

  final String title;
  final bool enableChat;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.12,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(width * 0.1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            enableChat
                ? width10
                : IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374151),
              ),
            ),
            enableChat
                ? SvgPicture.asset(
              'assets/images/chat_icon.svg',
              height: 45,
            )
                : width10
          ],
        ),
      ),
    );
  }
}