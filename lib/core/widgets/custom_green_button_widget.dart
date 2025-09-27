import 'package:flutter/material.dart';
import 'package:packina/core/constants/const.dart';
import '../constants/colors.dart';

class CustomGreenButtonWidget extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color color;

  const CustomGreenButtonWidget({
    super.key,
    required this.name,
    this.onPressed,
    this.color = mainColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonWidth = constraints.maxWidth > 600
            ? width * 0.4
            : double.infinity;

        return SizedBox(
          width: buttonWidth,
          height: 50,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              disabledBackgroundColor: mainColor.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(100, 50),
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
                fontSize: constraints.maxWidth > 600 ? 20 : 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
