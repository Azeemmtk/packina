import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashVersionWidget extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> fade;

  const SplashVersionWidget({
    super.key,
    required this.controller,
    required this.fade,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: fade,
            child: Text(
              'Version 1.0.0',
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
