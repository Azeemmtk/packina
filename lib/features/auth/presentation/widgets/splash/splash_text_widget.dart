import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashTextWidget extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> fade;
  final Animation<Offset> slide;

  const SplashTextWidget({
    super.key,
    required this.controller,
    required this.fade,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SlideTransition(
          position: slide,
          child: FadeTransition(
            opacity: fade,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
              ),
              child: Text(
                'PackIna',
                style: GoogleFonts.zenDots(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
