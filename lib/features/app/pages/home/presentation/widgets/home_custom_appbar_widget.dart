import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../auth/presentation/screens/sign_in_screen.dart';

class HomeCustomAppbarWidget extends StatelessWidget {
  const HomeCustomAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(width * 0.1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Container(
            decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          padding: const EdgeInsets.symmetric(
              horizontal: 4, vertical: 4),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCV2BT4s-9VHuSPY0hF-wXQMqcHzjl76lbXSVv_vE0XLm1gsNZI5oNbo0-8QH4PKU91PHAolqn_CcwBb389vu7vQYqqBUOUMhXqsShZWO31BlMz7CvnOCaXCFFWbJdzpAY7t-LuAua5C7QdIlE4szqdRZHLk0eRRegTfrRdcPTQ0zwMT7Qg_H9qDgH_1LkagoKJh-jg0IZdNFyEXFbbMHhdMebFNrRl4c6kvzqEbHXX0LCWv695yNAC_PLfzrnCiImB4jU7LZ0d_FLg',
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Azeem ali',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Maradu, ernakualm',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: IconButton(onPressed: () {

                  }, icon: Icon(Icons.chat))
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Explore',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374151),
              ),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151),
                ),
                children: [
                  TextSpan(text: 'Nearby '),
                  TextSpan(
                    text: 'Hostels',
                    style: TextStyle(color: Colors.green),
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