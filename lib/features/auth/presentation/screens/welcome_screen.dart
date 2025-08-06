import 'package:flutter/material.dart';
import 'package:packina/features/auth/presentation/screens/sign_in_screen.dart';

import '../../../../core/constants/const.dart';
import '../widgets/curved_container_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurvedContainerWidget(
                height: height * 0.68,
                title: 'Welcome',
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Welcome to PackInn, your ultimate hostel booking app! Easily explore and manage bookings.",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
