import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashLoadingWidget extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> fade;

  const SplashLoadingWidget({
    super.key,
    required this.controller,
    required this.fade,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: fade,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Initializing...',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
