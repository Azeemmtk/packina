import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/const.dart';

class CustomGreenButtonWidget extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color color;

  const CustomGreenButtonWidget({
    super.key,
    required this.name,
    this.onPressed,
    this.color= mainColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: mainColor.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(100, 50), // Ensure a reasonable minimum size
        ),
        child: isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}